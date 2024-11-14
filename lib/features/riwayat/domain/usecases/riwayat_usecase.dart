import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:fpdart/fpdart.dart';

import '../../data/models/riwayat_model.dart';
import '../repositories/riwayat_repository.dart';

class RiwayatUsecase {
  final RiwayatRepository _riwayatRepository;
  const RiwayatUsecase(this._riwayatRepository);

  Future<Either<AppwriteException, List<RiwayatModel>>> fetchAllRiwayat({
    required User user,
    bool latest = false,
  }) async {
    return await _riwayatRepository.fetchAllRiwayat(
      user: user,
      latest: latest,
    );
  }

  Future<Either<AppwriteException, void>> deleteRiwayat({
    required String histId,
  }) {
    return _riwayatRepository.deleteRiwayat(histId: histId);
  }

  Future<Either<AppwriteException, RiwayatModel>> fetchDisease({
    required String idDisease,
  }) {
    return _riwayatRepository.fetchDisease(
      idDisease: idDisease,
    );
  }
}
