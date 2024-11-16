import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fpdart/fpdart.dart';

import '../../../user/data/models/user_model.dart';
import '../../domain/repositories/komunitas_repository.dart';
import '../models/comment_model.dart';
import '../models/post_model.dart';

class KomunitasRepositoryImpl implements KomunitasRepository {
  final Client client;
  const KomunitasRepositoryImpl({required this.client});

  @override
  Future<Either<AppwriteException, List<PostModel>>> fetchAllPosts({
    bool latest = false,
    int? max,
  }) async {
    try {
      List<String> queries = [Query.orderDesc("\$createdAt")];
      if (max != null) queries.add(Query.limit(max));

      final response = await Databases(client).listDocuments(
        databaseId: dotenv.get("APPWRITE_DATABASES_ID"),
        collectionId: dotenv.get("APPWRITE_POST_COLLECTION_ID"),
        queries: queries,
      );

      // Convert responses to PostModel
      List<PostModel> posts = List<PostModel>.from(
        response.documents.map((doc) => PostModel.fromMap(doc.data)),
      );

      // If not sort by time, sort by likes count
      if (!latest) {
        posts.sort(
          (a, b) => (b.likes ?? []).length.compareTo((a.likes ?? []).length),
        );
      }

      return Right(posts);
    } on AppwriteException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppwriteException, List<PostModel>>> fetchAktivitas({
    required User user,
    required String filter,
  }) async {
    try {
      // Get user data
      final response = await Databases(client)
          .getDocument(
            databaseId: dotenv.get("APPWRITE_DATABASES_ID"),
            collectionId: dotenv.get("APPWRITE_USER_COLLECTION_ID"),
            documentId: user.$id,
          )
          .then((doc) => UserModel.fromMap(doc.data));

      // Set all queries by filter
      List<String> queries = [];
      switch (filter) {
        case 'Postingan':
          if (response.posts?.isNotEmpty ?? false) {
            queries.add(Query.equal("\$id", response.posts));
          }
          break;
        case 'Disukai':
          if (response.likedPosts?.isNotEmpty ?? false) {
            queries.add(Query.equal("\$id", response.likedPosts));
          }
          break;
        case 'Komentar':
          if (response.comments?.isNotEmpty ?? false) {
            queries.add(Query.equal("\$id", response.comments));
          }
          break;
        default:
          List<String> combineQueries = [];
          if (response.posts?.isNotEmpty ?? false) {
            combineQueries.add(Query.equal("\$id", response.posts));
          }
          if (response.likedPosts?.isNotEmpty ?? false) {
            combineQueries.add(Query.equal("\$id", response.likedPosts));
          }
          if (response.comments?.isNotEmpty ?? false) {
            combineQueries.add(Query.equal("\$id", response.comments));
          }

          if (combineQueries.length == 1) {
            queries.add(combineQueries[0]);
          } else if (combineQueries.length > 1) {
            queries.add(Query.or(combineQueries));
          }
          break;
      }

      // If user doesn't have activity, return []
      if (queries.isEmpty) return const Right([]);

      final userActivity = await Databases(client).listDocuments(
        databaseId: dotenv.get("APPWRITE_DATABASES_ID"),
        collectionId: dotenv.get("APPWRITE_POST_COLLECTION_ID"),
        queries: queries,
      );

      //  Convert to PostModel
      List<PostModel> posts = List<PostModel>.from(
        userActivity.documents.map((doc) => PostModel.fromMap(doc.data)),
      );

      return Right(posts);
    } on AppwriteException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppwriteException, void>> createPost({
    required PostModel post,
  }) async {
    try {
      await Databases(client).createDocument(
        databaseId: dotenv.get("APPWRITE_DATABASES_ID"),
        collectionId: dotenv.get("APPWRITE_POST_COLLECTION_ID"),
        documentId: ID.unique(),
        data: post.toMap(),
      );

      return const Right(null);
    } on AppwriteException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppwriteException, void>> deleteAllPosts() async {
    try {
      final documents = await Databases(client).listDocuments(
        databaseId: dotenv.get("APPWRITE_DATABASES_ID"),
        collectionId: dotenv.get("APPWRITE_POST_COLLECTION_ID"),
      );

      for (final document in documents.documents) {
        await Databases(client).deleteDocument(
          databaseId: dotenv.get("APPWRITE_DATABASES_ID"),
          collectionId: dotenv.get("APPWRITE_POST_COLLECTION_ID"),
          documentId: document.$id,
        );
      }

      return const Right(null);
    } on AppwriteException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppwriteException, void>> likePost({
    required String uid,
    required PostModel post,
  }) async {
    try {
      await Databases(client).updateDocument(
        databaseId: dotenv.get("APPWRITE_DATABASES_ID"),
        collectionId: dotenv.get("APPWRITE_POST_COLLECTION_ID"),
        documentId: post.id.toString(),
        data: {'likes': post.likes},
      );

      return const Right(null);
    } on AppwriteException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppwriteException, List<CommentModel>>> fetchComments({
    required String postId,
    bool latest = false,
  }) async {
    try {
      final response = await Databases(client).listDocuments(
        databaseId: dotenv.get("APPWRITE_DATABASES_ID"),
        collectionId: dotenv.get("APPWRITE_COMMENT_COLLECTION_ID"),
        queries: [
          Query.equal('id_post', postId),
          Query.orderDesc("\$createdAt"),
        ],
      );

      final comments = List<CommentModel>.from(
        response.documents.map((doc) {
          final comment = CommentModel.fromMap(doc.data);
          return comment.copyWith(
            likes: (doc.data['likes'] as List<dynamic>?)
                ?.map((like) => like['\$id'].toString())
                .toList(),
          );
        }),
      );

      if (!latest) {
        comments.sort(
          (a, b) => (b.likes ?? []).length.compareTo((a.likes ?? []).length),
        );
      }

      return Right(comments);
    } on AppwriteException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppwriteException, void>> createComment({
    required CommentModel comment,
  }) async {
    try {
      await Databases(client).createDocument(
        databaseId: dotenv.get("APPWRITE_DATABASES_ID"),
        collectionId: dotenv.get("APPWRITE_COMMENT_COLLECTION_ID"),
        documentId: ID.unique(),
        data: comment.toMap(),
      );

      return const Right(null);
    } on AppwriteException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppwriteException, void>> likeComment({
    required String uid,
    required CommentModel comment,
  }) async {
    try {
      await Databases(client).updateDocument(
        databaseId: dotenv.get("APPWRITE_DATABASES_ID"),
        collectionId: dotenv.get("APPWRITE_COMMENT_COLLECTION_ID"),
        documentId: comment.id.toString(),
        data: {'likes': comment.likes},
      );

      return const Right(null);
    } on AppwriteException catch (e) {
      return Left(e);
    }
  }
}
