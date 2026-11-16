import 'package:flutter/foundation.dart';
import '../models/alert_model.dart';
import '../models/occurrence_model.dart';
import '../models/territory_model.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';
import '../services/notification_service.dart';

enum AppStatus { loading, success, error }

class AppState extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  final StorageService _storageService = StorageService();

  AppStatus status = AppStatus.loading;

  List<TerritoryModel> territories = [];
  List<AlertModel> alerts = [];
  List<OccurrenceModel> occurrences = [];

  bool notificationsEnabled = true;
  bool urgentNotifications = true;
  bool criticalNotifications = true;

  String? errorMessage;

  int get territoryCount => territories.length;
  int get alertCount => alerts.length;
  int get occurrenceCount => occurrences.length;

  // Soma alertas territoriais e ocorrências manuais.
  int get urgentCount =>
      alerts.where((a) => a.priority == AlertPriority.urgent).length +
      occurrences.where((o) => o.priority.trim().toLowerCase() == 'urgente').length;

  int get criticalCount =>
      alerts.where((a) => a.priority == AlertPriority.critical).length +
      occurrences.where((o) => o.priority.trim().toLowerCase() == 'crítico').length;

  int get attentionCount =>
      alerts.where((a) => a.priority == AlertPriority.attention).length +
      occurrences.where((o) => o.priority.trim().toLowerCase() == 'atenção').length;

  int get normalCount =>
      alerts.where((a) => a.priority == AlertPriority.normal).length +
      occurrences.where((o) => o.priority.trim().toLowerCase() == 'normal').length;

  Future<void> initialize() async {
    status = AppStatus.loading;
    errorMessage = null;
    notifyListeners();

    try {
      occurrences = await _storageService.loadOccurrences();

      notificationsEnabled =
          await _storageService.loadNotificationsEnabled();

      urgentNotifications =
          await _storageService.loadUrgentEnabled();

      criticalNotifications =
          await _storageService.loadCriticalEnabled();

      territories = await _apiService.fetchTerritories();

      _generateAlerts();

      status = AppStatus.success;
    } catch (e) {
      errorMessage = 'Erro ao carregar os dados: $e';
      status = AppStatus.error;
    }

    notifyListeners();
  }

  void _generateAlerts() {
    final List<AlertModel> generated = [];

    for (final territory in territories) {
      final value = territory.vegetationIndex;

      final AlertPriority priority;

      if (value >= 50) {
        priority = AlertPriority.urgent;
      } else if (value >= 35) {
        priority = AlertPriority.critical;
      } else if (value >= 18) {
        priority = AlertPriority.attention;
      } else {
        priority = AlertPriority.normal;
      }

      generated.add(
        AlertModel(
          id: 'AL-${territory.id}',
          title: priority == AlertPriority.normal
              ? 'Monitoramento de rotina'
              : 'Variação no índice de vegetação',
          description:
              'Análise do ${territory.name}, região ${territory.region}.',
          territoryId: territory.id,
          priority: priority,
          evidence: 'Índice demonstrativo de vegetação: $value.',
          confidence: 0,
          limitation:
              'Dados sintéticos para demonstração. '
              'A classificação exige validação humana.',
          createdAt: DateTime.now(),
        ),
      );
    }

    alerts = generated;
  }

  Future<bool> addOccurrence(OccurrenceModel occurrence) async {
    final territoryExists =
        territories.any((t) => t.id == occurrence.territoryId);

    if (!territoryExists) {
      return false;
    }

    if (occurrences.any((o) => o.id == occurrence.id)) {
      return false;
    }

    occurrences = [occurrence, ...occurrences];

    await _storageService.saveOccurrences(occurrences);

    notifyListeners();

    final priority = occurrence.priority.toLowerCase();

    final shouldNotify = notificationsEnabled &&
        ((priority == 'urgente' && urgentNotifications) ||
            (priority == 'crítico' && criticalNotifications));

    if (shouldNotify) {
      try {
        await NotificationService.instance.show(
          title: 'Nova ocorrência ${occurrence.priority.toLowerCase()}',
          body:
              '${occurrence.type}: '
              '${findTerritory(occurrence.territoryId)?.name ?? 'Trecho'}',
        );
      } catch (_) {
        // A ocorrência permanece salva mesmo se a notificação falhar.
      }
    }

    return true;
  }

  Future<void> removeOccurrence(String id) async {
    occurrences = occurrences.where((o) => o.id != id).toList();

    await _storageService.saveOccurrences(occurrences);

    notifyListeners();
  }

  Future<void> updateOccurrenceStatus(
    String id,
    String newStatus,
  ) async {
    occurrences = occurrences.map((occurrence) {
      if (occurrence.id != id) {
        return occurrence;
      }

      return OccurrenceModel(
        id: occurrence.id,
        territoryId: occurrence.territoryId,
        type: occurrence.type,
        description: occurrence.description,
        createdAt: occurrence.createdAt,
        status: newStatus,
        priority: occurrence.priority,
        latitude: occurrence.latitude,
        longitude: occurrence.longitude,
      );
    }).toList();

    await _storageService.saveOccurrences(occurrences);

    notifyListeners();
  }

  Future<void> updateNotificationSettings({
    bool? enabled,
    bool? urgent,
    bool? critical,
  }) async {
    notificationsEnabled = enabled ?? notificationsEnabled;
    urgentNotifications = urgent ?? urgentNotifications;
    criticalNotifications = critical ?? criticalNotifications;

    await _storageService.saveNotificationSettings(
      enabled: notificationsEnabled,
      urgent: urgentNotifications,
      critical: criticalNotifications,
    );

    notifyListeners();
  }

  TerritoryModel? findTerritory(String id) {
    for (final territory in territories) {
      if (territory.id == id) return territory;
    }

    return null;
  }

  AlertModel? findAlert(String id) {
    for (final alert in alerts) {
      if (alert.id == id) return alert;
    }

    return null;
  }
}