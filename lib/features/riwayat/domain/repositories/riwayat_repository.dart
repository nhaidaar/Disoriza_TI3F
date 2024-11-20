import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/models/riwayat_model.dart';

abstract class RiwayatRepository {
  Future<Either<Exception, List<RiwayatModel>>> fetchAllRiwayat({
    required String uid,
    int? max,
  });

  Future<Either<Exception, RiwayatModel?>> scanDisease({
    required String uid,
    required XFile image,
  });

  Future<Either<Exception, void>> deleteRiwayat({required String riwayatId});
}
