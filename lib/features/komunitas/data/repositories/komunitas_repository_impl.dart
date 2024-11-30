import 'dart:typed_data';

import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../auth/data/models/user_model.dart';
import '../../domain/repositories/komunitas_repository.dart';
import '../models/comment_model.dart';
import '../models/post_model.dart';

class KomunitasRepositoryImpl implements KomunitasRepository {
  final SupabaseClient client;
  const KomunitasRepositoryImpl({required this.client});

  @override
  Future<Either<Exception, List<PostModel>>> fetchAllPosts({
    bool latest = false,
    int? max,
  }) async {
    try {
      final response = await client.from('posts').select('''
                    *,
                    users (
                      id,
                      name,
                      email,
                      profile_picture
                    ),
                    comments (
                      id_user
                    ),
                    liked_posts (
                      id_user
                    )
                  ''').order('created_at', ascending: false);

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
  Future<Either<Exception, List<PostModel>>> fetchAktivitas({
    required String uid,
    required String filter,
  }) async {
    try {
      late List<Map<String, dynamic>> response;

      switch (filter) {
        case 'Postingan':
          response = await client.from('posts').select('''
                *,
                users (
                  id,
                  name,
                  email,
                  profile_picture
                ),
                comments (
                  id_user
                ),
                liked_posts (
                  id_user
                )
              ''').eq('id_user', uid).order('created_at', ascending: false);
          break;
        case 'Disukai':
          response = await client.from('posts').select('''
                *,
                users (
                  id,
                  name,
                  email,
                  profile_picture
                ),
                comments (
                  id_user
                ),
                liked_posts!inner (
                  id_user
                )
              ''').eq('liked_posts.id_user', uid).order('created_at', ascending: false);
          break;
        case 'Komentar':
          response = await client.from('posts').select('''
                *,
                users (
                  id,
                  name,
                  email,
                  profile_picture
                ),
                comments!inner (
                  id_user
                ),
                liked_posts (
                  id_user
                )
              ''').eq('comments.id_user', uid).order('created_at', ascending: false);
          break;
        default:
          // response = await client
          //     .from('posts')
          //     .select(queries)
          //     .or('id_user.eq.$uid,liked_posts.id_user.eq.$uid,comments.id_user.eq.$uid')
          //     .order('created_at', ascending: false);
          response = [];
          break;
      }

      List<PostModel> posts = List<PostModel>.from(
        response.map((post) => PostModel.fromMap(post)),
      );

      return Right(posts);
    } on Exception catch (e) {
      print(e);
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, List<PostModel>>> searchPost({required String search}) async {
    try {
      final response = await client.from('posts').select('''
                    *,
                    users (
                      id,
                      name,
                      email,
                      profile_picture
                    ),
                    comments (
                      id_user
                    ),
                    liked_posts (
                      id_user
                    )
                  ''').like('title', '%$search%').order('created_at', ascending: false);

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
      final response = await client.from('comments').select('''
            *,
            users (
              id,
              name,
              email,
              profile_picture
            ),
            liked_comments (
              id_user
            )
          ''').eq('id_post', postId).order('created_at', ascending: false);

      List<CommentModel> comments = List<CommentModel>.from(
        response.map((comment) => CommentModel.fromMap(comment)),
      );

      if (!latest) {
        comments.sort((a, b) => (b.likes ?? []).length.compareTo((a.likes ?? []).length));
      }

      return Right(comments);
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
}
