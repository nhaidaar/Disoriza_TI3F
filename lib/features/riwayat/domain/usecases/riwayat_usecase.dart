import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/models/riwayat_model.dart';
import '../repositories/riwayat_repository.dart';

class RiwayatUsecase {
  final RiwayatRepository _riwayatRepository;
  const RiwayatUsecase(this._riwayatRepository);

  Future<Either<Exception, List<RiwayatModel>>> fetchAllRiwayat({
    required String uid,
    int? max,
  }) async {
    return await _riwayatRepository.fetchAllRiwayat(
      uid: uid,
      max: max,
    );
  }

  Future<Either<Exception, RiwayatModel>> scanDisease({
    required String uid,
    required XFile image,
  }) async {
    return await _riwayatRepository.scanDisease(
      uid: uid,
      image: image,
    );
  }

  Future<Either<Exception, void>> deleteRiwayat({required String riwayatId}) async {
    return await _riwayatRepository.deleteRiwayat(riwayatId: riwayatId);
  }
}
