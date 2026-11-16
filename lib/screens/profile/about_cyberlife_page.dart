
import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../widgets/profile/cyberlife_animated_logo.dart';

class AboutCyberLifePage extends StatelessWidget {
  const AboutCyberLifePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre o CyberLife'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Center(
            child: CyberLifeAnimatedLogo(),
          ),
          const SizedBox(height: 25),
          const Center(
            child: Text(
              'CYBERLIFE',
              style: TextStyle(
                color: AppTheme.cyan,
                fontSize: 25,
                fontWeight: FontWeight.bold,
                letterSpacing: 3,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tecnologia que transforma a vida das pessoas.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.muted,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 28),
          _AboutSection(
            title: 'O projeto',
            description:
                'O CyberLife é um projeto acadêmico desenvolvido para a Global Solution da FIAP. A proposta é utilizar tecnologia para apoiar o monitoramento territorial, organizar ocorrências e apresentar alertas que auxiliem na tomada de decisões.',
            icon: Icons.hub_outlined,
          ),
          _AboutSection(
            title: 'Objetivo',
            description:
                'Facilitar o acompanhamento de territórios por meio de indicadores, mapas, registros de ocorrências e alertas de prioridade.',
            icon: Icons.track_changes,
          ),
          _AboutSection(
            title: 'Tecnologias utilizadas',
            description:
                'Flutter e Dart para a interface mobile, Provider para gerenciamento de estado, SharedPreferences para persistência local, OpenStreetMap para visualização do mapa e Geolocator para recursos de localização.',
            icon: Icons.code,
          ),
          _AboutSection(
            title: 'Global Solution 2026.2',
            description:
                'Projeto acadêmico FIAP — CitizenTech: Territory Predictive Insights.',
            icon: Icons.school_outlined,
          ),
          const SizedBox(height: 25),
          const Text(
            'CYBERLIFE • FIAP',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.muted,
              fontSize: 10,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }
}

class _AboutSection extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const _AboutSection({
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.panel,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppTheme.line),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppTheme.cyan, size: 25),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppTheme.text,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  description,
                  style: const TextStyle(
                    color: AppTheme.muted,
                    fontSize: 12,
                    height: 1.5,
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
