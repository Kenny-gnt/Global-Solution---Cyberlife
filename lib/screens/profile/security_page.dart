import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../theme/app_theme.dart';
import '../../widgets/profile/cyberlife_animated_logo.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({super.key});

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  static const String _consentKey = 'cyberlife_data_consent';

  bool _consent = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadConsent();
  }

  Future<void> _loadConsent() async {
    final preferences = await SharedPreferences.getInstance();
    final savedConsent = preferences.getBool(_consentKey) ?? false;

    if (!mounted) return;

    setState(() {
      _consent = savedConsent;
      _loading = false;
    });
  }

  Future<void> _updateConsent(bool value) async {
    setState(() {
      _consent = value;
    });

    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_consentKey, value);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Preferência salva neste dispositivo.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacidade e segurança'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Center(
            child: CyberLifeAnimatedLogo(),
          ),
          const SizedBox(height: 25),

          const Text(
            'Proteção e transparência',
            style: TextStyle(
              color: AppTheme.text,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 18),

          _SecurityCard(
            icon: Icons.storage_outlined,
            title: 'Armazenamento local',
            description:
                'As ocorrências e preferências desta demonstração são armazenadas localmente no dispositivo.',
          ),

          _SecurityCard(
            icon: Icons.science_outlined,
            title: 'Dados de demonstração',
            description:
                'Os territórios e indicadores apresentados utilizam dados ilustrativos. Eles não representam medições reais.',
          ),

          _SecurityCard(
            icon: Icons.person_outline,
            title: 'Decisão humana',
            description:
                'Os alertas são indicadores de apoio. A validação e a decisão sobre intervenções devem ser feitas por pessoas responsáveis.',
          ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.panel,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.line),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Preferência de consentimento',
                  style: TextStyle(
                    color: AppTheme.text,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Registre sua preferência sobre o uso dos registros para acompanhamento local.',
                  style: TextStyle(
                    color: AppTheme.muted,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),

                if (_loading)
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                else
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    value: _consent,
                    activeThumbColor: AppTheme.cyan,
                    title: const Text(
                      'Concordo com o uso demonstrativo dos dados',
                      style: TextStyle(
                        color: AppTheme.text,
                        fontSize: 12,
                      ),
                    ),
                    onChanged: _updateConsent,
                  ),

                const SizedBox(height: 5),
                const Text(
                  'Esta opção registra sua escolha neste dispositivo. Nesta versão, ela não bloqueia o registro de ocorrências nem altera o processamento dos dados.',
                  style: TextStyle(
                    color: AppTheme.muted,
                    fontSize: 11,
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

class _SecurityCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _SecurityCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.panel,
        borderRadius: BorderRadius.circular(14),
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
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    color: AppTheme.muted,
                    fontSize: 12,
                    height: 1.4,
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