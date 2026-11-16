
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/alert_model.dart';
import '../state/app_state.dart';
import '../models/occurrence_model.dart';
import '../theme/app_theme.dart';
import '../widgets/cyber_components.dart';

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Central de alertas'),
      ),
      body: Builder(
        builder: (context) {
          if (state.status == AppStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.status == AppStatus.error) {
            return Center(
              child: Text(
                state.errorMessage ?? 'Erro ao carregar alertas.',
                style: const TextStyle(color: AppTheme.text),
                textAlign: TextAlign.center,
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const SectionTitle(
                title: 'Monitoramento de eventos',
                subtitle: 'Alertas classificados por prioridade',
              ),

              const SizedBox(height: 20),

              _AlertSummary(state: state),

              const SizedBox(height: 22),

              const Text(
                'ALERTAS TERRITORIAIS',
                style: TextStyle(
                  color: AppTheme.cyan,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),

              const SizedBox(height: 12),

              if (state.alerts.isEmpty)
                const _EmptyMessage(
                  message: 'Nenhum alerta territorial disponível.',
                )
              else
                ...state.alerts.map(
                  (alert) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _TerritoryAlertCard(alert: alert),
                  ),
                ),

              const SizedBox(height: 15),

              const Text(
                'OCORRÊNCIAS REGISTRADAS',
                style: TextStyle(
                  color: AppTheme.cyan,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),

              const SizedBox(height: 12),

              if (state.occurrences.isEmpty)
                const _EmptyMessage(
                  message: 'Nenhuma ocorrência cadastrada até o momento.',
                )
              else
                ...state.occurrences.map(
                  (occurrence) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _OccurrenceAlertCard(
                      occurrence: occurrence,
                      territoryName: state
                              .findTerritory(occurrence.territoryId)
                              ?.name ??
                          'Território não identificado',
                    ),
                  ),
                ),

              const SizedBox(height: 20),

              const Text(
                'Os alertas são ferramentas de apoio. A decisão final '
                'deve sempre passar por avaliação humana.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppTheme.muted,
                  fontSize: 11,
                  height: 1.5,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _AlertSummary extends StatelessWidget {
  final AppState state;

  const _AlertSummary({required this.state});

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
                color: Colors.orange,
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

class _TerritoryAlertCard extends StatelessWidget {
  final AlertModel alert;

  const _TerritoryAlertCard({required this.alert});

  Color get priorityColor {
    switch (alert.priority) {
      case AlertPriority.urgent:
        return AppTheme.danger;
      case AlertPriority.critical:
        return Colors.orange;
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
    final territoryName =
        context.read<AppState>().findTerritory(alert.territoryId)?.name ??
            'Território não identificado';

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

class _OccurrenceAlertCard extends StatelessWidget {
  final OccurrenceModel occurrence;
  final String territoryName;

  const _OccurrenceAlertCard({
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
        return Colors.orange;
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
              Icon(Icons.assignment_outlined, color: priorityColor),
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

class _EmptyMessage extends StatelessWidget {
  final String message;

  const _EmptyMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    return CyberPanel(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppTheme.muted,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
