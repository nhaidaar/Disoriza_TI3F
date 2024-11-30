import './disease_model.dart';

class RiwayatModel {
  final bool haveDisease;
  final int? id;
  final String? idUser;
  final DiseaseModel? idDisease;
  final double? accuracy;
  final String? urlImage;
  final DateTime? date;

  const RiwayatModel({
    this.haveDisease = true,
    this.id,
    this.idUser,
    this.idDisease,
    this.accuracy,
    this.urlImage,
    this.date,
  });

  factory RiwayatModel.fromMap(Map<String, dynamic> map) {
    return RiwayatModel(
      id: map['id'],
      idUser: map['id_user'],
      idDisease: DiseaseModel.fromMap(map['diseases']),
      accuracy: map['accuracy'],
      urlImage: map['url_image'],
      date: DateTime.parse(map['created_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_user': idUser,
      'id_disease': idDisease?.id,
      'accuracy': accuracy ?? 0,
      'url_image': urlImage,
    };
  }

  RiwayatModel copyWith({
    bool? haveDisease,
    int? id,
    String? idUser,
    DiseaseModel? idDisease,
    String? urlImage,
    double? accuracy,
    DateTime? date,
  }) {
    return RiwayatModel(
      haveDisease: haveDisease ?? this.haveDisease,
      id: id ?? this.id,
      idUser: idUser ?? this.idUser,
      idDisease: idDisease ?? this.idDisease,
      accuracy: accuracy ?? this.accuracy,
      urlImage: urlImage ?? this.urlImage,
      date: date ?? this.date,
    );
  }
}
