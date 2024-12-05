import 'dart:typed_data';

import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../auth/data/models/user_model.dart';
import '../../domain/repositories/komunitas_repository.dart';
import '../models/comment_model.dart';
import '../models/post_with_comment.dart';
import '../models/post_model.dart';

class KomunitasRepositoryImpl implements KomunitasRepository {
  final SupabaseClient client;
  const KomunitasRepositoryImpl({required this.client});

  final postQuery = '''
                *,
                users (
                  id,
                  name,
                  email,
                  profile_picture,
                  is_admin
                ),
                comments (
                  id_user
                ),
                liked_posts (
                  id_user
                ),
                reported_posts (
                  id_user
                )
              ''';

  final commentQuery = '''
            *,
            users (
              id,
              name,
              email,
              profile_picture,
              is_admin
            ),
            liked_comments (
              id_user
            ),
            reported_comments (
              id_user
            )
          ''';

  @override
  Future<Either<Exception, List<PostModel>>> fetchAllPosts({
    bool latest = false,
    int? max,
  }) async {
    try {
      final response = await client.from('posts').select(postQuery).order('created_at', ascending: false);

      // Convert responses to PostModel
      List<PostModel> posts = List<PostModel>.from(
        response.map((doc) => PostModel.fromMap(doc)),
      );

      // If not sort by time, sort by likes count
      if (!latest) posts.sort((a, b) => (b.likes ?? []).length.compareTo((a.likes ?? []).length));

      // If max set, take only max length of posts
      if (max != null) return Right(posts.take(max).toList());

      return Right(posts);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, List<PostModel>>> fetchReportedPosts() async {
    try {
      final response = await client
          .from('posts')
          .select(postQuery)
          .not('reported_posts', 'is', null)
          .order('created_at', ascending: false);

      // Convert responses to PostModel
      List<PostModel> posts = List<PostModel>.from(
        response.map((doc) => PostModel.fromMap(doc)),
      );

      posts.sort((a, b) => (b.reports ?? []).length.compareTo((a.reports ?? []).length));

      return Right(posts);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, List<PostModel>>> fetchAktivitas({
    required String uid,
    required String filter,
  }) async {
    try {
      late List<Map<String, dynamic>> response;

      switch (filter) {
        // Select post that user posted
        case 'Postingan':
          response =
              await client.from('posts').select(postQuery).eq('id_user', uid).order('created_at', ascending: false);
          break;

        // Select post that user liked
        case 'Disukai':
          final likedPosts = await client
              .from('liked_posts')
              .select('id_post')
              .eq('id_user', uid)
              .then((res) => List<String>.from(res.map((item) => item['id_post'].toString())));
          if (likedPosts.isEmpty) return const Right([]);

          response = await client
              .from('posts')
              .select(postQuery)
              .inFilter('id', likedPosts)
              .order('created_at', ascending: false);
          break;

        // Select post that user commented
        case 'Komentar':
          final commentedPosts = await client
              .from('comments')
              .select('id_post')
              .eq('id_user', uid)
              .then((res) => List<String>.from(res.map((item) => item['id_post'].toString())));
          if (commentedPosts.isEmpty) return const Right([]);

          response = await client
              .from('posts')
              .select(postQuery)
              .inFilter('id', commentedPosts)
              .order('created_at', ascending: false);
          break;

        // Select post that user reported
        case 'Dilaporkan':
          final reportedPosts = await client
              .from('reported_posts')
              .select('id_post')
              .eq('id_user', uid)
              .then((res) => List<String>.from(res.map((item) => item['id_post'].toString())));
          if (reportedPosts.isEmpty) return const Right([]);

          response = await client
              .from('posts')
              .select(postQuery)
              .inFilter('id', reportedPosts)
              .order('created_at', ascending: false);
          break;

        // No filter
        default:
          response = [];
          break;
      }

      List<PostModel> posts = List<PostModel>.from(
        response.map((post) => PostModel.fromMap(post)),
      );

      return Right(posts);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, List<PostModel>>> searchPost({required String search}) async {
    try {
      final response = await client
          .from('posts')
          .select(postQuery)
          .ilike('title', '%$search%')
          .order('created_at', ascending: false);

      // Convert responses to PostModel
      List<PostModel> posts = List<PostModel>.from(
        response.map((doc) => PostModel.fromMap(doc)),
      );

      return Right(posts);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, void>> createPost({
    required String title,
    required String description,
    required String uid,
    Uint8List? image,
  }) async {
    try {
      final time = DateTime.now().millisecondsSinceEpoch;
      final path = '/$uid/$time.png';

      String? url;
      if (image != null) {
        await client.storage.from('user_posts').uploadBinary(path, image);
        url = client.storage.from('user_posts').getPublicUrl(path);
      }

      final post = PostModel(
        title: title,
        content: description,
        author: UserModel(id: uid),
        urlImage: url,
      );

      await client.from('posts').insert(post.toMap());
      return const Right(null);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, void>> deletePost({required String postId}) async {
    try {
      await client.from('posts').delete().eq('id', postId);
      return const Right(null);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, void>> likePost({
    required String uid,
    required String postId,
  }) async {
    try {
      final existingLike = await client.from('liked_posts').select().eq('id_user', uid).eq('id_post', postId);
      if (existingLike.isNotEmpty) return const Right(null);

      await client.from('liked_posts').insert({
        'id_user': uid,
        'id_post': postId,
      });

      return const Right(null);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, void>> reportPost({
    required String uid,
    required String postId,
  }) async {
    try {
      final existingReport = await client.from('reported_posts').select().eq('id_user', uid).eq('id_post', postId);
      if (existingReport.isNotEmpty) return const Right(null);

      await client.from('reported_posts').insert({
        'id_user': uid,
        'id_post': postId,
      });

      return const Right(null);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, void>> unlikePost({
    required String uid,
    required String postId,
  }) async {
    try {
      await client.from('liked_posts').delete().eq('id_user', uid).eq('id_post', postId);

      return const Right(null);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, List<CommentModel>>> fetchComments({
    required String postId,
    bool latest = false,
  }) async {
    try {
      final response = await client
          .from('comments')
          .select(commentQuery)
          .eq('id_post', postId)
          .order('created_at', ascending: false);

      // Convert to CommentModel
      List<CommentModel> comments = List<CommentModel>.from(
        response.map((comment) => CommentModel.fromMap(comment)),
      );

      if (!latest) comments.sort((a, b) => (b.likes ?? []).length.compareTo((a.likes ?? []).length));

      return Right(comments);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, List<PostWithCommentModel>>> fetchReportedComments() async {
    try {
      final commentsResponse = await client
          .from('comments')
          .select(commentQuery)
          .not('reported_comments', 'is', null)
          .order('created_at', ascending: false);
      List<CommentModel> comments = commentsResponse.map((commentData) {
        return CommentModel.fromMap(commentData);
      }).toList();

      final postsResponse = await client
          .from('posts')
          .select(postQuery)
          .inFilter('id', comments.map((comment) => comment.idPost).toList());
      final postsMap = {for (var post in postsResponse) post['id']: PostModel.fromMap(post)}; // For iteration the posts

      List<PostWithCommentModel> postWithComment = comments.map((comment) {
        return PostWithCommentModel(commentModel: comment, postModel: postsMap[comment.idPost]!);
      }).toList();

      postWithComment.sort((a, b) {
        return (b.commentModel.reports ?? []).length.compareTo((a.commentModel.reports ?? []).length);
      });

      return Right(postWithComment);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, void>> createComment({
    required CommentModel comment,
  }) async {
    try {
      await client.from('comments').insert(comment.toMap());
      return const Right(null);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, void>> deleteComment({required String commentId}) async {
    try {
      await client.from('comments').delete().eq('id', commentId);
      return const Right(null);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, void>> likeComment({
    required String uid,
    required String commentId,
  }) async {
    try {
      final existingLike = await client.from('liked_comments').select().eq('id_user', uid).eq('id_comment', commentId);
      if (existingLike.isNotEmpty) return const Right(null);

      await client.from('liked_comments').insert({
        'id_user': uid,
        'id_comment': commentId,
      });

      return const Right(null);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, void>> unlikeComment({
    required String uid,
    required String commentId,
  }) async {
    try {
      await client.from('liked_comments').delete().eq('id_user', uid).eq('id_comment', commentId);

      return const Right(null);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, void>> reportComment({
    required String uid,
    required String commentId,
  }) async {
    try {
      final existingReport =
          await client.from('reported_comments').select().eq('id_user', uid).eq('id_comment', commentId);
      if (existingReport.isNotEmpty) return const Right(null);

      await client.from('reported_comments').insert({
        'id_user': uid,
        'id_comment': commentId,
      });

      return const Right(null);
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
