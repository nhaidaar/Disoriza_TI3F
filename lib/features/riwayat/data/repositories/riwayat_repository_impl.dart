import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/repositories/riwayat_repository.dart';
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
            disease:id_disease(
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
  Future<Either<Exception, void>> deleteRiwayat({required String riwayatId}) async {
    try {
      await client.from('riwayat').delete().eq('id', riwayatId);
      return const Right(null);
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
