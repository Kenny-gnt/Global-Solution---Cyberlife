import 'package:flutter/material.dart';

import '../../state/app_state.dart';
import '../../theme/app_theme.dart';
import '../cyber_components.dart';

class AlertSummary extends StatelessWidget {
  final AppState state;

  const AlertSummary({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return CyberPanel(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _SummaryItem(
                label: 'Urgentes',
                value: state.urgentCount,
                color: AppTheme.danger,
              ),
              _SummaryItem(
                label: 'Críticos',
                value: state.criticalCount,
                color: AppTheme.magenta,
              ),
              _SummaryItem(
                label: 'Atenção',
                value: state.attentionCount,
                color: AppTheme.warning,
              ),
              _SummaryItem(
                label: 'Normais',
                value: state.normalCount,
                color: AppTheme.success,
              ),
            ],
          ),
          const Divider(color: AppTheme.line, height: 25),
          Text(
            '${state.alertCount} alertas territoriais • '
            '${state.occurrenceCount} ocorrências registradas',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppTheme.muted,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final int value;
  final Color color;

  const _SummaryItem({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$value',
          style: TextStyle(
            color: color,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: AppTheme.muted,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
