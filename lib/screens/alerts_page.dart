import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/alerts/alert_summary.dart';
import '../widgets/alerts/territory_alert_card.dart';
import '../widgets/alerts/occurrence_alert_card.dart';
import '../widgets/cyber_components.dart';

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    if (state.status == AppStatus.loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (state.status == AppStatus.error) {
      return Scaffold(
        appBar: AppBar(title: const Text('Central de alertas')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.cloud_off_outlined,
                  color: AppTheme.muted,
                  size: 42,
                ),
                const SizedBox(height: 12),
                Text(
                  state.errorMessage ?? 'Erro ao carregar alertas.',
                  style: const TextStyle(color: AppTheme.text),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Verifique sua conexão e tente novamente.',
                  style: TextStyle(color: AppTheme.muted, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Central de alertas'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SectionTitle(
            title: 'Monitoramento de eventos',
            subtitle: 'Alertas classificados por prioridade',
          ),
          const SizedBox(height: 20),

          AlertSummary(state: state),

          const SizedBox(height: 22),

          const _SectionLabel(title: 'ALERTAS TERRITORIAIS'),
          const SizedBox(height: 12),

          if (state.alerts.isEmpty)
            const _EmptyMessage(
              message: 'Nenhum alerta territorial disponível.',
            )
          else
            ...state.alerts.map(
              (alert) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: TerritoryAlertCard(
                  alert: alert,
                  territoryName:
                      state.findTerritory(alert.territoryId)?.name ??
                          'Território não identificado',
                ),
              ),
            ),

          const SizedBox(height: 15),

          const _SectionLabel(title: 'OCORRÊNCIAS REGISTRADAS'),
          const SizedBox(height: 12),

          if (state.occurrences.isEmpty)
            const _EmptyMessage(
              message: 'Nenhuma ocorrência cadastrada até o momento.',
            )
          else
            ...state.occurrences.map(
              (occurrence) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: OccurrenceAlertCard(
                  occurrence: occurrence,
                  territoryName:
                      state.findTerritory(occurrence.territoryId)?.name ??
                          'Território não identificado',
                ),
              ),
            ),

          const SizedBox(height: 20),

          // RESPONSABILIDADE HUMANA
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.cyan.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.cyan.withValues(alpha: 0.45),
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.verified_user_outlined,
                      color: AppTheme.cyan,
                      size: 22,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'SUPERVISÃO HUMANA OBRIGATÓRIA',
                        style: TextStyle(
                          color: AppTheme.cyan,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  'Os alertas são recomendações de apoio ao monitoramento. '
                  'Toda classificação deve ser verificada por uma pessoa '
                  'responsável antes de qualquer decisão ou intervenção.',
                  style: TextStyle(
                    color: AppTheme.text,
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // TRANSPARÊNCIA
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.muted.withValues(alpha: 0.2),
              ),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  color: AppTheme.muted,
                  size: 19,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Os indicadores são demonstrativos e utilizam dados '
                    'simulados. A classificação não representa uma '
                    'previsão garantida. As condições reais podem variar '
                    'e exigem validação humana.',
                    style: TextStyle(
                      color: AppTheme.muted,
                      fontSize: 11,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String title;

  const _SectionLabel({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: AppTheme.cyan,
        fontSize: 11,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.5,
      ),
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