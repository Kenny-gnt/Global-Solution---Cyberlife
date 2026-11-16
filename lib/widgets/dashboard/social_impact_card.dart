import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/app_state.dart';

class SocialImpactCard extends StatelessWidget {
  const SocialImpactCard({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final total = state.occurrences.length;

    return Card(
      color: const Color(0xFF111D2B),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Colors.cyanAccent.withValues(alpha: 0.25),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.groups_outlined,
                  color: Colors.cyanAccent,
                ),
                SizedBox(width: 10),
                Text(
                  'IMPACTO SOCIAL',
                  style: TextStyle(
                    color: Colors.cyanAccent,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text(
              '$total',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Ocorrências registradas',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Os registros ajudam a identificar necessidades '
              'do território e apoiar o direcionamento de ações.',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.65),
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Indicador de acompanhamento. Não representa '
              'impacto social comprovado.',
              style: TextStyle(
                color: Colors.orangeAccent.withValues(alpha: 0.9),
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
