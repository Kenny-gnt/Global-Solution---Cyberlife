class TeamModel {
  final String id;
  final String name;
  final String responsible;
  final String members;

  const TeamModel({
    required this.id,
    required this.name,
    required this.responsible,
    required this.members,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'responsible': responsible,
      'members': members,
    };
  }

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      responsible: json['responsible'] ?? '',
      members: json['members'] ?? '',
    );
  }
}