import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../cyber_components.dart';

class PriorityPanel extends StatelessWidget {
  final int urgent;
  final int critical;
  final int attention;
  final int normal;

  const PriorityPanel({
    super.key,
    required this.urgent,
    required this.critical,
    required this.attention,
    required this.normal,
  });

  @override
  Widget build(BuildContext context) {
    final total = urgent + critical + attention + normal;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'Nível de prioridade',
          subtitle: 'Distribuição dos alertas e ocorrências identificados',
        ),
        const SizedBox(height: 14),
        CyberPanel(
          child: total == 0
              ? const Text(
                  'Nenhum alerta ou ocorrência identificado.',
                  style: TextStyle(color: AppTheme.muted),
                )
              : Column(
                  children: [
                    _priorityRow(
                      'Urgente',
                      urgent,
                      total,
                      AppTheme.danger,
                    ),
                    const SizedBox(height: 17),
                    _priorityRow(
                      'Crítico',
                      critical,
                      total,
                      AppTheme.magenta,
                    ),
                    const SizedBox(height: 17),
                    _priorityRow(
                      'Atenção',
                      attention,
                      total,
                      AppTheme.warning,
                    ),
                    const SizedBox(height: 17),
                    _priorityRow(
                      'Normal',
                      normal,
                      total,
                      AppTheme.success,
                    ),
                  ],
                ),
        ),
      ],
    );
  }

  Widget _priorityRow(
    String title,
    int quantity,
    int total,
    Color color,
  ) {
    final progress = total == 0 ? 0.0 : quantity / total;

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