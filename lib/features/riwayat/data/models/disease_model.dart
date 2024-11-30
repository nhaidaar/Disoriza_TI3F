class DiseaseModel {
  final int? id;
  final String? name;
  final String? definition;
  final String? solution;
  final String? symtomp;

  const DiseaseModel({
    this.id,
    this.name,
    this.definition,
    this.solution,
    this.symtomp,
  });

  factory DiseaseModel.fromMap(Map<String, dynamic> map) {
    return DiseaseModel(
      id: map['id'],
      name: map['name'],
      definition: map['definition'],
      solution: map['solution'],
      symtomp: map['symtomp'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'definition': definition,
      'solution': solution,
      'symtomp': symtomp,
    };
  }

  DiseaseModel copyWith({
    int? id,
    String? name,
    String? definition,
    String? solution,
    String? symtomp,
  }) {
    return DiseaseModel(
      id: id ?? this.id,
      name: name ?? this.name,
      definition: definition ?? this.definition,
      solution: solution ?? this.solution,
      symtomp: symtomp ?? this.symtomp,
    );
  }
}
