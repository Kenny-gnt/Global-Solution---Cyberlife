
import 'package:flutter/material.dart';

import '../../models/alert_model.dart';
import '../../theme/app_theme.dart';
import '../cyber_components.dart';

class RecentAlertsPanel extends StatelessWidget {
  final List<AlertModel> alerts;
  final String? Function(String territoryId) findTerritoryName;

  const RecentAlertsPanel({
    super.key,
    required this.alerts,
    required this.findTerritoryName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'Últimos alertas',
          subtitle: 'Ocorrências que exigem acompanhamento',
        ),
        const SizedBox(height: 13),
        CyberPanel(
          child: alerts.isEmpty
              ? const Text(
                  'Nenhum alerta disponível no momento.',
                  style: TextStyle(color: AppTheme.muted),
                )
              : Column(
                  children: alerts.take(3).map((alert) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _AlertItem(
                        title: alert.title,
                        location: findTerritoryName(alert.territoryId) ??
                            'Trecho não identificado',
                        evidence: alert.evidence,
                        color: _priorityColor(alert.priority),
                        level: _priorityName(alert.priority),
                      ),
                    );
                  }).toList(),
                ),
        ),
      ],
    );
  }

  Color _priorityColor(AlertPriority priority) {
    switch (priority) {
      case AlertPriority.urgent:
        return AppTheme.danger;
      case AlertPriority.critical:
        return AppTheme.magenta;
      case AlertPriority.attention:
        return AppTheme.warning;
      case AlertPriority.normal:
        return AppTheme.success;
    }
  }

  String _priorityName(AlertPriority priority) {
    switch (priority) {
      case AlertPriority.urgent:
        return 'Urgente';
      case AlertPriority.critical:
        return 'Crítico';
      case AlertPriority.attention:
        return 'Atenção';
      case AlertPriority.normal:
        return 'Normal';
    }
  }
}

class _AlertItem extends StatelessWidget {
  final String title;
  final String location;
  final String evidence;
  final String level;
  final Color color;

  const _AlertItem({
    required this.title,
    required this.location,
    required this.evidence,
    required this.color,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.notifications_active_outlined,
            color: color,
            size: 18,
          ),
        ),
        const SizedBox(width: 11),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppTheme.text,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$location • $evidence',
                style: const TextStyle(
                  color: AppTheme.muted,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
        SeverityLabel(text: level, color: color),
      ],
    );
  }
}
