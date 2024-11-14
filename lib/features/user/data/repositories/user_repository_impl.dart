import 'package:appwrite/appwrite.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fpdart/fpdart.dart';

import '../models/user_model.dart';
import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final Client client;
  const UserRepositoryImpl({required this.client});

  @override
  Future<Either<AppwriteException, UserModel>> fetchUserModel({
    required String uid,
  }) async {
    try {
      final response = await Databases(client).getDocument(
        databaseId: dotenv.get("APPWRITE_DATABASES_ID"),
        collectionId: dotenv.get("APPWRITE_USER_COLLECTION_ID"),
        documentId: uid,
      );

      return Right(UserModel.fromMap(response.data));
    } on AppwriteException catch (e) {
      return Left(e);
    }
  }

  // @override
  // Future<Either<Exception, bool>> checkEmailExists({required String email}) async {
  //   try {
  //     final response = await Databases(client).listDocuments(
  //       databaseId: dotenv.get("DATABASE_ID"),
  //       collectionId: dotenv.get("COLLECTION_USERS_ID"),
  //       queries: [Query.equal("email", email)],
  //     );

  //     return Right(response.documents.isNotEmpty);
  //   } on AppwriteException catch (e) {
  //     return Left(e);
  //   }
  // }
}
