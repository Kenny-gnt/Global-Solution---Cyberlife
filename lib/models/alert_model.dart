enum AlertPriority {
  normal,
  attention,
  critical,
  urgent,
}

class AlertModel {
  final String id;
  final String title;
  final String description;
  final String territoryId;
  final AlertPriority priority;
  final String evidence;
  final double confidence;
  final String limitation;
  final DateTime createdAt;
  final bool requiresHumanReview;

  const AlertModel({
    required this.id,
    required this.title,
    required this.description,
    required this.territoryId,
    required this.priority,
    required this.evidence,
    required this.confidence,
    required this.limitation,
    required this.createdAt,
    this.requiresHumanReview = true,
  });

  String get priorityLabel {
    switch (priority) {
      case AlertPriority.normal:
        return 'Normal';
      case AlertPriority.attention:
        return 'Atenção';
      case AlertPriority.critical:
        return 'Crítico';
      case AlertPriority.urgent:
        return 'Urgente';
    }
  }

  factory AlertModel.fromJson(Map<String, dynamic> json) {
    return AlertModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      territoryId: json['territoryId'] ?? '',
      priority: AlertPriority.values.firstWhere(
        (item) => item.name == json['priority'],
        orElse: () => AlertPriority.normal,
      ),
      evidence: json['evidence'] ?? '',
      confidence: (json['confidence'] as num?)?.toDouble() ?? 0,
      limitation: json['limitation'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ??
          DateTime.now(),
      requiresHumanReview: json['requiresHumanReview'] ?? true,
    );
  }
}
