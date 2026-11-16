
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class TerritoryHeader extends StatelessWidget {
  const TerritoryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: AppTheme.cyan.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.hub_outlined, color: AppTheme.cyan),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CYBERLIFE',
                style: TextStyle(
                  color: AppTheme.text,
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),
              Text(
                'CENTRO DE MONITORAMENTO',
                style: TextStyle(
                  color: AppTheme.muted,
                  fontSize: 9,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
        const Icon(Icons.circle, color: AppTheme.success, size: 9),
        const SizedBox(width: 6),
        const Text(
          'SISTEMA ATIVO',
          style: TextStyle(
            color: AppTheme.success,
            fontSize: 9,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
