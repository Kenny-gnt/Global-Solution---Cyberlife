
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../cyber_components.dart';

class TerritoryMetrics extends StatelessWidget {
  final int territories;
  final int alerts;
  final int occurrences;

  const TerritoryMetrics({
    super.key,
    required this.territories,
    required this.alerts,
    required this.occurrences,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: MetricCard(
                title: 'Trechos',
                value: territories.toString().padLeft(2, '0'),
                description: 'Cadastrados',
                icon: Icons.route,
                color: AppTheme.cyan,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: MetricCard(
                title: 'Alertas',
                value: alerts.toString().padLeft(2, '0'),
                description: 'Em acompanhamento',
                icon: Icons.warning_amber,
                color: AppTheme.warning,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: MetricCard(
                title: 'Ocorrências',
                value: occurrences.toString().padLeft(2, '0'),
                description: 'Registradas',
                icon: Icons.assignment_outlined,
                color: AppTheme.magenta,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: MetricCard(
                title: 'Equipes',
                value: '--',
                description: 'Sem cadastro',
                icon: Icons.groups_outlined,
                color: AppTheme.success,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
