import './disease_model.dart';
import '../../../user/data/models/user_model.dart';

class RiwayatModel {
  final String? id;
  final UserModel? idUser;
  final DiseaseModel? idDisease;
  final int? accuracy;
  final String? urlImage;
  final int? date;

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
      idUser: UserModel.fromMap(map['idUser']),
      idDisease: DiseaseModel.fromMap(map['idDisease']),
      accuracy: map['accuracy'],
      urlImage: map['url_image'],
      date: map['date'],
    );
  }

  // Convert to map for Appwrite
  Map<String, dynamic> toMap() {
    return {
      'idUser': idUser?.id,
      'idDisease': idDisease?.id,
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
    int? date,
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
