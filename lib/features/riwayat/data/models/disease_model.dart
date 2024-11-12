class DiseaseModel {
    final String? id;
    final String? name;
    final String? definition;
    final String? solution;
    final String? symtomps;

    const DiseaseModel({
      this.id,
      this.name,
      this.definition,
      this.solution,
      this.symtomps,
    });

    factory DiseaseModel.fromMap(Map<String, dynamic> map) {
      return DiseaseModel(
        id: map['\$id'],
        name: map['name'],
        definition: map['definition'],
        solution: map['solution'],
        symtomps: map['symtomps'],
      );
  }

  // Convert to map for Appwrite
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'definition': definition,
      'solution': solution,
      'symtomps': symtomps,
    };
  }

  DiseaseModel copyWith({
    String? id,
    String? name,
    String? definition,
    String? solution,
    String? symtomps,
  }) {
    return DiseaseModel(
      id: id ?? this.id,
      name: name ?? this.name,
      definition: definition ?? this.definition,
      solution: solution ?? this.solution,
      symtomps: symtomps ?? this.symtomps
    );
  }
}