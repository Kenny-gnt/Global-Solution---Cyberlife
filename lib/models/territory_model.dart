class TerritoryModel {
  final String id;
  final String name;
  final String region;
  final String type;
  final double vegetationIndex;
  final double? latitude;
  final double? longitude;
  final String description;

  const TerritoryModel({
    required this.id,
    required this.name,
    required this.region,
    required this.type,
    required this.vegetationIndex,
    this.latitude,
    this.longitude,
    this.description = '',
  });

  bool get hasCoordinates =>
      latitude != null && longitude != null;

  factory TerritoryModel.fromJson(Map<String, dynamic> json) {
    return TerritoryModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      region: json['region'] ?? '',
      type: json['type'] ?? '',
      vegetationIndex:
          (json['vegetationIndex'] as num?)?.toDouble() ?? 0,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'region': region,
      'type': type,
      'vegetationIndex': vegetationIndex,
      'latitude': latitude,
      'longitude': longitude,
      'description': description,
    };
  }
}
