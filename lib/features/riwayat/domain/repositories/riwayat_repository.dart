import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:fpdart/fpdart.dart';

import '../../data/models/riwayat_model.dart';

abstract class RiwayatRepository {
  Future<Either<AppwriteException, List<RiwayatModel>>> fetchAllRiwayat({
    required User user,
    bool latest = false,
  });
  Future<Either<AppwriteException, void>> deleteRiwayat({
    required String histId,
  });
  Future<Either<AppwriteException, RiwayatModel>> fetchDisease({
    required String idDisease,
  });
}
