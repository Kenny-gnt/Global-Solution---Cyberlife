import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/territory/territory_header.dart';
import '../widgets/territory/territory_metrics.dart';
import '../widgets/territory/priority_panel.dart';
import '../widgets/territory/recent_alerts_panel.dart';
import '../widgets/dashboard/social_impact_card.dart';

class TerritoryPage extends StatelessWidget {
  const TerritoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    if (appState.status == AppStatus.loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: AppTheme.cyan,
          ),
        ),
      );
    }

    if (appState.status == AppStatus.error) {
      return Scaffold(
        body: _StatusMessage(
          icon: Icons.cloud_off_outlined,
          title: 'Não foi possível carregar os dados',
          message: appState.errorMessage ?? 'Verifique sua conexão e tente novamente.',
          buttonText: 'Tentar novamente',
          onPressed: () => appState.initialize(),
        ),
      );
    }

    final territories = appState.territories;
    final alerts = appState.alerts;
    final occurrences = appState.occurrences;

    if (territories.isEmpty) {
      return const Scaffold(
        body: _StatusMessage(
          icon: Icons.location_searching,
          title: 'Nenhum território encontrado',
          message:
              'Ainda não existem dados disponíveis para apresentar. Tente atualizar o monitoramento.',
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 30),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const TerritoryHeader(),
                const SizedBox(height: 30),

                const Text(
                  'Visão geral',
                  style: TextStyle(
                    color: AppTheme.text,
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),

                const Text(
                  'Acompanhamento operacional do território.',
                  style: TextStyle(
                    color: AppTheme.muted,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 22),

                _buildSummary(),

                const SizedBox(height: 25),

                const Text(
                  'Indicadores do território',
                  style: TextStyle(
                    color: AppTheme.text,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),

                const Text(
                  'Resumo dos dados monitorados',
                  style: TextStyle(
                    color: AppTheme.muted,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 13),

                TerritoryMetrics(
                  territories: territories.length,
                  alerts: alerts.length,
                  occurrences: occurrences.length,
                ),

                const SizedBox(height: 26),

                const SocialImpactCard(),

                const SizedBox(height: 26),

                PriorityPanel(
               urgent: appState.urgentCount,
               critical: appState.criticalCount,
               attention: appState.attentionCount,
               normal: appState.normalCount,
              ),

                const SizedBox(height: 26),

                RecentAlertsPanel(
                  alerts: alerts,
                  findTerritoryName: (id) {
                    return appState.findTerritory(id)?.name;
                  },
                ),

                const SizedBox(height: 20),

                const Text(
                  'CYBERLIFE • MONITORAMENTO TERRITORIAL',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppTheme.muted,
                    fontSize: 9,
                    letterSpacing: 1,
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummary() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF123A57),
            Color(0xFF14243B),
          ],
        ),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: AppTheme.cyan.withValues(alpha: 0.35),
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.insights, color: AppTheme.cyan, size: 20),
              SizedBox(width: 9),
              Text(
                'RESUMO OPERACIONAL',
                style: TextStyle(
                  color: AppTheme.cyan,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Text(
            'Monitoramento inteligente, decisões mais rápidas.',
            style: TextStyle(
              color: AppTheme.text,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Consulte indicadores, acompanhe alertas e organize as ações de manutenção.',
            style: TextStyle(
              color: Color(0xFFB6C9DC),
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusMessage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String? buttonText;
  final VoidCallback? onPressed;

  const _StatusMessage({
    required this.icon,
    required this.title,
    required this.message,
    this.buttonText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: AppTheme.cyan,
              size: 48,
            ),
            const SizedBox(height: 18),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppTheme.text,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppTheme.muted,
                fontSize: 13,
                height: 1.5,
              ),
            ),
            if (buttonText != null && onPressed != null) ...[
              const SizedBox(height: 22),
              ElevatedButton.icon(
                onPressed: onPressed,
                icon: const Icon(Icons.refresh),
                label: Text(buttonText!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}