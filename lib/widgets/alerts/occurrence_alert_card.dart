import 'package:flutter/material.dart';

import '../../models/occurrence_model.dart';
import '../../theme/app_theme.dart';
import '../cyber_components.dart';

class OccurrenceAlertCard extends StatelessWidget {
  final OccurrenceModel occurrence;
  final String territoryName;

  const OccurrenceAlertCard({
    super.key,
    required this.occurrence,
    required this.territoryName,
  });

  Color get priorityColor {
    switch (occurrence.priority.toLowerCase()) {
      case 'urgente':
      case 'urgent':
        return AppTheme.danger;
      case 'crítico':
      case 'critico':
      case 'critical':
        return AppTheme.magenta;
      case 'atenção':
      case 'atencao':
        return AppTheme.warning;
      default:
        return AppTheme.success;
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
                Icons.assignment_outlined,
                color: priorityColor,
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  occurrence.type,
                  style: const TextStyle(
                    color: AppTheme.text,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
              SeverityLabel(
                text: occurrence.priority.toUpperCase(),
                color: priorityColor,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            occurrence.description,
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
          const SizedBox(height: 8),
          _InfoLine(
            icon: Icons.access_time,
            text: _formatDate(occurrence.createdAt),
          ),
          const SizedBox(height: 8),
          _InfoLine(
            icon: Icons.pending_actions,
            text: 'Status: ${occurrence.status}',
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.cyan.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppTheme.cyan.withValues(alpha: 0.25),
              ),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.person_outline,
                  color: AppTheme.cyan,
                  size: 17,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Ocorrência registrada manualmente. A prioridade e as providências devem ser avaliadas por uma pessoa responsável.',
                    style: TextStyle(
                      color: AppTheme.muted,
                      fontSize: 11,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();

    return '$day/$month/$year';
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