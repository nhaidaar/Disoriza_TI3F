import './disease_model.dart';
import '../../../user/data/models/user_model.dart';

class RiwayatModel {
  final String? id;
  final UserModel? id_user;
  final DiseaseModel? id_disease;
  final int? accuracy;
  
  final String? url_image;

  const RiwayatModel({
    this.id,
    this.id_user,
    this.id_disease,
    this.accuracy,
    this.url_image,
  });

  factory RiwayatModel.fromMap(Map<String, dynamic> map) {
    return RiwayatModel(
      id: map['\$id'],
      id_user: UserModel.fromMap(map['id_user']),
      id_disease: DiseaseModel.fromMap(map['id_disease']),
      accuracy: map['accuracy'],
      url_image: map['url_image'],
    );
  }

  // Convert to map for Appwrite
  Map<String, dynamic> toMap() {
    return {
      'id_user': id_user?.id,
      'id_disease': id_disease?.id,
      'accuracy': accuracy,
      'url_image': url_image,
    };
  }

  RiwayatModel copyWith({
    String? id,
    UserModel? id_user,
    DiseaseModel? id_disease,
    String? url_image,
    int? accuracy,
  }) {
    return RiwayatModel(
      id: id ?? this.id,
      id_user: id_user ?? this.id_user,
      id_disease: id_disease ?? this.id_disease,
      accuracy: accuracy ?? this.accuracy,
      url_image: url_image ?? this.url_image,
    );
  }
}
