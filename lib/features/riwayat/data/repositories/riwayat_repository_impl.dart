import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fpdart/fpdart.dart';

import '../../domain/repositories/riwayat_repository.dart';
import '../models/riwayat_model.dart';

class RiwayatRepositoryImpl implements RiwayatRepository {
  final Client client;
  const RiwayatRepositoryImpl({required this.client});

@override
Future<Either<AppwriteException, List<RiwayatModel>>> fetchAllRiwayat({
  bool latest = false,
  required User user,
}) async {
  try {
    final response = await Databases(client).listDocuments(
      databaseId: dotenv.get("FLASK_APPWRITE_DATABASES_ID"),
      collectionId: dotenv.get("FLASK_APPWRITE_DETAILS_HISTORY_COLLECTION_ID"),
      queries: [
        Query.orderDesc("\$createdAt"), 
        // Query.equal('id_user', user),
      ],
    );

    List<RiwayatModel> riwayat = List<RiwayatModel>.from(
      response.documents.map((doc) => RiwayatModel.fromMap(doc.data)),
    );

    return Right(riwayat);
  } on AppwriteException catch (e) {
    return Left(e);
  }
}


  @override
  Future<Either<AppwriteException, void>> deleteRiwayat({required String histId}) async {
    try {
      final documents = await Databases(client).listDocuments(
        databaseId: dotenv.get("FLASK_APPWRITE_DATABASES_ID"),
        collectionId: dotenv.get("FLASK_APPWRITE_DETAILS_HISTORY_COLLECTION_ID"),
        queries: [
          Query.equal('id_riwayat', histId),
        ],
      );
      if (documents.documents.isNotEmpty) {
        final documentId = documents.documents.first.$id;
        await Databases(client).deleteDocument(
          databaseId: dotenv.get("FLASK_APPWRITE_DATABASES_ID"),
          collectionId: dotenv.get("FLASK_APPWRITE_DETAILS_HISTORY_COLLECTION_ID"),
          documentId: documentId,
        );
        return const Right(null);
      } else {
        return const Right(null);
      }
    } on AppwriteException catch (e) {
      return Left(e);
    }
  }

@override
Future<Either<AppwriteException, RiwayatModel>> fetchDisease({
  required String id_disease,
  }) async {
    try {
      // Fetch disease documents matching id_disease
      final diseaseResponse = await Databases(client).listDocuments(
        databaseId: dotenv.get("FLASK_APPWRITE_DATABASES_ID"),
        collectionId: dotenv.get("FLASK_APPWRITE_DETAILS_HISTORY_COLLECTION_ID"),
        queries: [
          Query.equal('id_disease', id_disease),
        ],
      );

      // Map disease documents to DiseaseModel
      final disease = RiwayatModel.fromMap(diseaseResponse.documents.first.data);
      return Right(disease);
    } on AppwriteException catch (e) {
      return Left(e);
    }
  }
}
