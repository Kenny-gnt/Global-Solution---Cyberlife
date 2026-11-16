import 'package:flutter/material.dart';

import '../../models/alert_model.dart';
import '../../theme/app_theme.dart';
import '../cyber_components.dart';

class TerritoryAlertCard extends StatelessWidget {
  final AlertModel alert;
  final String territoryName;

  const TerritoryAlertCard({
    super.key,
    required this.alert,
    required this.territoryName,
  });

  Color get priorityColor {
    switch (alert.priority) {
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

  String get priorityName {
    switch (alert.priority) {
      case AlertPriority.urgent:
        return 'URGENTE';
      case AlertPriority.critical:
        return 'CRÍTICO';
      case AlertPriority.attention:
        return 'ATENÇÃO';
      case AlertPriority.normal:
        return 'NORMAL';
    }
  }

  @override
  Widget build(BuildContext context) {
    return CyberPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: priorityColor,
                size: 22,
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  alert.title,
                  style: const TextStyle(
                    color: AppTheme.text,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
              SeverityLabel(
                text: priorityName,
                color: priorityColor,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            alert.description,
            style: const TextStyle(
              color: AppTheme.muted,
              fontSize: 12,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          _InfoLine(
            icon: Icons.location_on_outlined,
            text: territoryName,
          ),
          const SizedBox(height: 10),
          _InfoLine(
            icon: Icons.analytics_outlined,
            text: 'Evidência: ${alert.evidence}',
          ),
          const SizedBox(height: 10),
          _InfoLine(
            icon: Icons.info_outline,
            text: 'Confiança informada: ${alert.confidence}',
          ),
          const SizedBox(height: 10),
          _InfoLine(
            icon: Icons.warning_amber_outlined,
            text: 'Limitação: ${alert.limitation}',
          ),
        ],
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoLine({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppTheme.cyan, size: 15),
        const SizedBox(width: 7),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: AppTheme.muted,
              fontSize: 11,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
