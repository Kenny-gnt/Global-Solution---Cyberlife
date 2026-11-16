import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/app_state.dart';
import '../../theme/app_theme.dart';
import '../../widgets/profile/cyberlife_animated_logo.dart';

class NotificationSettingsPage extends StatelessWidget {
  const NotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificações'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Center(
            child: CyberLifeAnimatedLogo(),
          ),
          const SizedBox(height: 25),

          const Text(
            'Preferências de alerta',
            style: TextStyle(
              color: AppTheme.text,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),

          const Text(
            'Escolha quais notificações o CyberLife poderá enviar.',
            style: TextStyle(
              color: AppTheme.muted,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 20),

          _NotificationSwitch(
            title: 'Notificações gerais',
            subtitle: 'Ativar ou desativar todas as notificações.',
            value: state.notificationsEnabled,
            onChanged: (value) {
              state.updateNotificationSettings(enabled: value);
            },
          ),

          _NotificationSwitch(
            title: 'Alertas urgentes',
            subtitle: 'Receber avisos de prioridade urgente.',
            value: state.urgentNotifications,
            onChanged: state.notificationsEnabled
                ? (value) {
                    state.updateNotificationSettings(urgent: value);
                  }
                : null,
          ),

          _NotificationSwitch(
            title: 'Alertas críticos',
            subtitle: 'Receber avisos de prioridade crítica.',
            value: state.criticalNotifications,
            onChanged: state.notificationsEnabled
                ? (value) {
                    state.updateNotificationSettings(critical: value);
                  }
                : null,
          ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: AppTheme.cyan.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: AppTheme.cyan.withValues(alpha: 0.25),
              ),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  color: AppTheme.cyan,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'As notificações também dependem da permissão concedida ao aplicativo nas configurações do dispositivo.',
                    style: TextStyle(
                      color: AppTheme.muted,
                      fontSize: 12,
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
}

class _NotificationSwitch extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool>? onChanged;

  const _NotificationSwitch({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppTheme.panel,
      margin: const EdgeInsets.only(bottom: 12),
      child: SwitchListTile(
        value: value,
        onChanged: onChanged,
        activeThumbColor: AppTheme.cyan,
        title: Text(
          title,
          style: const TextStyle(
            color: AppTheme.text,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: AppTheme.muted,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}