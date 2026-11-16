class OccurrenceModel {
  final String id;
  final String territoryId;
  final String type;
  final String description;
  final DateTime createdAt;
  final String status;
  final String priority;
  final double? latitude;
  final double? longitude;

  const OccurrenceModel({
    required this.id,
    required this.territoryId,
    required this.type,
    required this.description,
    required this.createdAt,
    this.status = 'Em análise',
    this.priority = 'Normal',
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'territoryId': territoryId,
      'type': type,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'status': status,
      'priority': priority,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory OccurrenceModel.fromJson(Map<String, dynamic> json) {
    return OccurrenceModel(
      id: json['id']?.toString() ?? '',
      territoryId: json['territoryId']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      createdAt: DateTime.tryParse(
            json['createdAt']?.toString() ?? '',
          ) ??
          DateTime.now(),
      status: json['status']?.toString() ?? 'Em análise',
      priority: json['priority']?.toString() ?? 'Normal',
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );
  }

  OccurrenceModel copyWith({
    String? status,
    String? priority,
    double? latitude,
    double? longitude,
  }) {
    return OccurrenceModel(
      id: id,
      territoryId: territoryId,
      type: type,
      description: description,
      createdAt: createdAt,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
