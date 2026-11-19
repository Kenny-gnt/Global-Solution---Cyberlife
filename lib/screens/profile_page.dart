import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/cyber_components.dart';
import '../widgets/profile/profile_option.dart';
import '../widgets/profile/cyberlife_animated_logo.dart';

import 'teams_page.dart';
import 'profile/notification_settings_page.dart';
import 'profile/security_page.dart';
import 'profile/about_cyberlife_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Column(
                children: [
                  CyberLifeAnimatedLogo(),
                  SizedBox(height: 18),
                  Text(
                    'OPERADOR CYBERLIFE',
                    style: TextStyle(
                      color: AppTheme.text,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Central de configurações e informações',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppTheme.muted,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const SectionTitle(title: 'Configurações'),
            const SizedBox(height: 14),
            CyberPanel(
              child: Column(
                children: [
                  ProfileOption(
                    icon: Icons.groups_outlined,
                    title: 'Equipes',
                    subtitle: 'Cadastrar e gerenciar equipes operacionais',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const TeamsPage(),
                        ),
                      );
                    },
                  ),
                  const Divider(color: AppTheme.line),
                  ProfileOption(
                    icon: Icons.notifications_active_outlined,
                    title: 'Notificações',
                    subtitle: 'Configure os alertas do sistema',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const NotificationSettingsPage(),
                        ),
                      );
                    },
                  ),
                  const Divider(color: AppTheme.line),
                  ProfileOption(
                    icon: Icons.shield_outlined,
                    title: 'Privacidade e segurança',
                    subtitle: 'Dados, consentimento e transparência',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SecurityPage(),
                        ),
                      );
                    },
                  ),
                  const Divider(color: AppTheme.line),
                  ProfileOption(
                    icon: Icons.info_outline,
                    title: 'Sobre o CyberLife',
                    subtitle: 'Informações sobre o projeto',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AboutCyberLifePage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Center(
              child: Text(
                'CYBERLIFE • FIAP GLOBAL SOLUTION 2026.2',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppTheme.muted,
                  fontSize: 9,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}