import 'dart:math';

import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/repositories/riwayat_repository.dart';
import '../models/disease_model.dart';
import '../models/riwayat_model.dart';

class RiwayatRepositoryImpl implements RiwayatRepository {
  final SupabaseClient client;
  const RiwayatRepositoryImpl({required this.client});

  @override
  Future<Either<Exception, List<RiwayatModel>>> fetchAllRiwayat({
    required String uid,
    int? max,
  }) async {
    try {
      final response = await client.from('histories').select('''
            *,
            diseases (
              id,
              name,
              definition,
              solution,
              symtomp
            )
          ''').eq('id_user', uid).order('created_at', ascending: false);

      List<RiwayatModel> riwayat = List<RiwayatModel>.from(
        response.map((doc) => RiwayatModel.fromMap(doc)),
      );

      return Right(max == null ? riwayat : riwayat.take(max).toList());
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, RiwayatModel>> scanDisease({
    required String uid,
    required XFile image,
  }) async {
    try {
      final time = DateTime.now().millisecondsSinceEpoch;
      final extension = image.path.split('.').last;
      final path = '/$uid/$time.$extension';
      final imageBytes = await image.readAsBytes();

      await client.storage.from('user_histories').uploadBinary(path, imageBytes);
      final url = client.storage.from('user_histories').getPublicUrl(path);

      // Random type of disease (temporary)
      final id = Random().nextInt(5) + 1;
      final accuracy = Random().nextDouble() * 100;
      final disease = await client.from('diseases').select().eq('id', id).single().then((ds) {
        return DiseaseModel.fromMap(ds);
      });

      // Send riwayat model
      final riwayat = RiwayatModel(
        idUser: uid,
        idDisease: disease,
        accuracy: accuracy,
        urlImage: url,
      );
      await client.from('histories').insert(riwayat.toMap());

      return Right(riwayat);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, void>> deleteRiwayat({required String riwayatId}) async {
    try {
      await client.from('histories').delete().eq('id', riwayatId);
      return const Right(null);
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
