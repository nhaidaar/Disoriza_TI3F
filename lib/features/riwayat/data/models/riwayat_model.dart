import './disease_model.dart';
import '../../../user/data/models/user_model.dart';

class RiwayatModel {
  final String? id;
  final UserModel? idUser;
  final DiseaseModel? idDisease;
  final int? accuracy;
  final String? urlImage;
  final DateTime? date;

  const RiwayatModel({
    this.id,
    this.idUser,
    this.idDisease,
    this.accuracy,
    this.urlImage,
    this.date,
  });

  factory RiwayatModel.fromMap(Map<String, dynamic> map) {
    return RiwayatModel(
      id: map['\$id'],
      idUser: UserModel.fromMap(map['id_user']),
      idDisease: DiseaseModel.fromMap(map['id_disease']),
      accuracy: map['accuracy'],
      urlImage: map['url_image'],
      date: DateTime.parse(map['\$createdAt']),
    );
  }

  // Convert to map for Appwrite
  Map<String, dynamic> toMap() {
    return {
      'id_user': idUser?.id,
      'id_disease': idDisease?.id,
      'accuracy': accuracy ?? 0,
      'url_image': urlImage,
    };
  }

  RiwayatModel copyWith({
    String? id,
    UserModel? idUser,
    DiseaseModel? idDisease,
    String? urlImage,
    int? accuracy,
    DateTime? date,
  }) {
    return RiwayatModel(
      id: id ?? this.id,
      idUser: idUser ?? this.idUser,
      idDisease: idDisease ?? this.idDisease,
      accuracy: accuracy ?? this.accuracy,
      urlImage: urlImage ?? this.urlImage,
      date: date ?? this.date,
    );
  }
}
