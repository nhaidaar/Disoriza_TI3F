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
  }) async {
    try {
      final response = await Databases(client).listDocuments(
        databaseId: dotenv.get("FLASK_APPWRITE_DATABASES_ID"),
        collectionId: dotenv.get("FLASK_APPWRITE_POST_COLLECTION_ID"),
        queries: [Query.orderDesc("\$createdAt")],
      );

      List<PostModel> posts = List<PostModel>.from(
        response.documents.map((doc) {
          final post = PostModel.fromMap(doc.data);
          return post.copyWith(
            likes: (doc.data['likes'] as List<dynamic>?)
                ?.map((like) => like['\$id'].toString())
                .toList(),
            comments: (doc.data['comments'] as List<dynamic>?)
                ?.map((like) => like['\$id'].toString())
                .toList(),
          );
        }),
      );

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
      // final response = await Databases(client)
      //     .getDocument(
      //       databaseId: dotenv.get("FLASK_APPWRITE_DATABASES_ID"),
      //       collectionId: dotenv.get("FLASK_APPWRITE_USER_COLLECTION_ID"),
      //       documentId: user.$id,
      //     )
      //     .then((doc) => UserModel.fromMap(doc.data));

      List<PostModel> posts = [];

      // switch (filter) {
      //   case 'Semua':
      //     posts.addAll(response.posts ?? []);
      //     posts.addAll(response.likedPosts ?? []);
      //     break;
      //   case 'Postingan':
      //     posts.addAll(response.posts ?? []);
      //     break;
      //   case 'Disukai':
      //     posts.addAll(response.likedPosts ?? []);
      //     break;
      //   case 'Komentar':
      //     // queries.add(Query.contains('comments.\$id', user!.$id));
      //     break;
      //   default:
      //     break;
      // }

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
        databaseId: dotenv.get("FLASK_APPWRITE_DATABASES_ID"),
        collectionId: dotenv.get("FLASK_APPWRITE_POST_COLLECTION_ID"),
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
        databaseId: dotenv.get("FLASK_APPWRITE_DATABASES_ID"),
        collectionId: dotenv.get("FLASK_APPWRITE_POST_COLLECTION_ID"),
      );

      for (final document in documents.documents) {
        await Databases(client).deleteDocument(
          databaseId: dotenv.get("FLASK_APPWRITE_DATABASES_ID"),
          collectionId: dotenv.get("FLASK_APPWRITE_POST_COLLECTION_ID"),
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
        databaseId: dotenv.get("FLASK_APPWRITE_DATABASES_ID"),
        collectionId: dotenv.get("FLASK_APPWRITE_POST_COLLECTION_ID"),
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
        databaseId: dotenv.get("FLASK_APPWRITE_DATABASES_ID"),
        collectionId: dotenv.get("FLASK_APPWRITE_COMMENT_COLLECTION_ID"),
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
        databaseId: dotenv.get("FLASK_APPWRITE_DATABASES_ID"),
        collectionId: dotenv.get("FLASK_APPWRITE_COMMENT_COLLECTION_ID"),
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
        databaseId: dotenv.get("FLASK_APPWRITE_DATABASES_ID"),
        collectionId: dotenv.get("FLASK_APPWRITE_COMMENT_COLLECTION_ID"),
        documentId: comment.id.toString(),
        data: {'likes': comment.likes},
      );

      return const Right(null);
    } on AppwriteException catch (e) {
      return Left(e);
    }
  }
}
