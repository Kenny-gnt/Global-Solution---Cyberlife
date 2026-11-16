import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class CyberLifeAnimatedLogo extends StatefulWidget {
  const CyberLifeAnimatedLogo({super.key});

  @override
  State<CyberLifeAnimatedLogo> createState() =>
      _CyberLifeAnimatedLogoState();
}

class _CyberLifeAnimatedLogoState
    extends State<CyberLifeAnimatedLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.rotate(
                angle: _controller.value * 6.28318,
                child: Container(
                  width: 116,
                  height: 116,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: SweepGradient(
                      colors: [
                        AppTheme.cyan,
                        Colors.transparent,
                        AppTheme.cyan.withValues(alpha: 0.2),
                        Colors.transparent,
                        AppTheme.cyan,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.cyan.withValues(alpha: 0.25),
                        blurRadius: 18,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Container(
            width: 104,
            height: 104,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.panel,
              border: Border.all(
                color: AppTheme.cyan.withValues(alpha: 0.5),
                width: 1,
              ),
            ),
            child: ClipOval(
              child: Image.asset(
                'lib/assets/images/cyberlife_logo.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.hub_outlined,
                    color: AppTheme.cyan,
                    size: 58,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}