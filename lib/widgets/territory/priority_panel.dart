
import 'package:flutter/material.dart';

import '../../models/alert_model.dart';
import '../../theme/app_theme.dart';
import '../cyber_components.dart';

class PriorityPanel extends StatelessWidget {
  final List<AlertModel> alerts;

  const PriorityPanel({
    super.key,
    required this.alerts,
  });

  @override
  Widget build(BuildContext context) {
    final urgent = alerts.where((a) => a.priority == AlertPriority.urgent).length;
    final critical = alerts.where((a) => a.priority == AlertPriority.critical).length;
    final attention = alerts.where((a) => a.priority == AlertPriority.attention).length;
    final normal = alerts.where((a) => a.priority == AlertPriority.normal).length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'Nível de prioridade',
          subtitle: 'Distribuição dos alertas identificados',
        ),
        const SizedBox(height: 14),
        CyberPanel(
          child: alerts.isEmpty
              ? const Text(
                  'Nenhum alerta identificado.',
                  style: TextStyle(color: AppTheme.muted),
                )
              : Column(
                  children: [
                    _priorityRow('Urgente', urgent, AppTheme.danger),
                    const SizedBox(height: 17),
                    _priorityRow('Crítico', critical, AppTheme.magenta),
                    const SizedBox(height: 17),
                    _priorityRow('Atenção', attention, AppTheme.warning),
                    const SizedBox(height: 17),
                    _priorityRow('Normal', normal, AppTheme.success),
                  ],
                ),
        ),
      ],
    );
  }

  Widget _priorityRow(String title, int quantity, Color color) {
    final progress = alerts.isEmpty ? 0.0 : quantity / alerts.length;

    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 9),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: AppTheme.text,
                  fontSize: 12,
                ),
              ),
            ),
            Text(
              quantity.toString().padLeft(2, '0'),
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 5,
            backgroundColor: AppTheme.surfaceLight,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}
