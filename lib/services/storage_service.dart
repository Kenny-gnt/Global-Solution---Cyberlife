import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/occurrence_model.dart';

class StorageService {
  static const String _occurrencesKey = 'cyberlife_occurrences';
  static const String _notificationsKey = 'cyberlife_notifications_enabled';
  static const String _urgentKey = 'cyberlife_urgent_enabled';
  static const String _criticalKey = 'cyberlife_critical_enabled';

  Future<List<OccurrenceModel>> loadOccurrences() async {
    final preferences = await SharedPreferences.getInstance();
    final storedData = preferences.getString(_occurrencesKey);

    if (storedData == null || storedData.isEmpty) {
      return [];
    }

    try {
      final List<dynamic> decoded = jsonDecode(storedData);

      return decoded
          .map(
            (item) => OccurrenceModel.fromJson(
              Map<String, dynamic>.from(item),
            ),
          )
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> saveOccurrences(
    List<OccurrenceModel> occurrences,
  ) async {
    final preferences = await SharedPreferences.getInstance();

    final encoded = jsonEncode(
      occurrences.map((item) => item.toJson()).toList(),
    );

    await preferences.setString(_occurrencesKey, encoded);
  }

  Future<bool> loadNotificationsEnabled() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(_notificationsKey) ?? true;
  }

  Future<bool> loadUrgentEnabled() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(_urgentKey) ?? true;
  }

  Future<bool> loadCriticalEnabled() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(_criticalKey) ?? true;
  }

  Future<void> saveNotificationSettings({
    required bool enabled,
    required bool urgent,
    required bool critical,
  }) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setBool(_notificationsKey, enabled);
    await preferences.setBool(_urgentKey, urgent);
    await preferences.setBool(_criticalKey, critical);
  }
}
