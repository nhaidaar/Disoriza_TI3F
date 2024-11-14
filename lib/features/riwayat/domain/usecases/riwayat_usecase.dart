import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:fpdart/fpdart.dart';

import '../../data/models/riwayat_model.dart';
import '../repositories/riwayat_repository.dart';

class RiwayatUsecase {
  final RiwayatRepository _RiwayatRepository;
  const RiwayatUsecase(this._RiwayatRepository);

    Future<Either<AppwriteException, List<RiwayatModel>>> fetchAllRiwayat({
      required User user,
      bool latest = false,
    }) async {
      return await _RiwayatRepository.fetchAllRiwayat(
        user: user,
        latest: latest,
      );
    }
    Future<Either<AppwriteException, void>> deleteRiwayat({
      required String histId,
    }) {
      return _RiwayatRepository.deleteRiwayat(histId: histId);
    }
    Future<Either<AppwriteException, RiwayatModel>> fetchDisease({
      required String id_disease,
    }) {
      return _RiwayatRepository.fetchDisease(
        id_disease: id_disease,
      );
    }
}