import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AnalyticsCard extends StatelessWidget {
  const AnalyticsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.surfaceLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Evolução dos indicadores',
                style: TextStyle(
                  color: AppTheme.text,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              Icon(
                Icons.insights_rounded,
                color: AppTheme.cyan,
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Monitoramento estimado por período',
            style: TextStyle(color: AppTheme.muted, fontSize: 10),
          ),
          const SizedBox(height: 22),
          SizedBox(
            height: 130,
            width: double.infinity,
            child: CustomPaint(
              painter: _ChartPainter(),
            ),
          ),
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _ChartLabel(label: 'SEG'),
              _ChartLabel(label: 'TER'),
              _ChartLabel(label: 'QUA'),
              _ChartLabel(label: 'QUI'),
              _ChartLabel(label: 'SEX'),
              _ChartLabel(label: 'SÁB'),
              _ChartLabel(label: 'DOM'),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChartLabel extends StatelessWidget {
  final String label;

  const _ChartLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        color: AppTheme.muted,
        fontSize: 9,
      ),
    );
  }
}

class _ChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = AppTheme.surfaceLight
      ..strokeWidth = 1;

    for (int i = 0; i < 4; i++) {
      final y = size.height * i / 3;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        gridPaint,
      );
    }

    final points = [
      Offset(0, size.height * 0.72),
      Offset(size.width * 0.16, size.height * 0.58),
      Offset(size.width * 0.33, size.height * 0.65),
      Offset(size.width * 0.5, size.height * 0.35),
      Offset(size.width * 0.66, size.height * 0.43),
      Offset(size.width * 0.83, size.height * 0.22),
      Offset(size.width, size.height * 0.30),
    ];

    final path = Path()..moveTo(points.first.dx, points.first.dy);

    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    final linePaint = Paint()
      ..color = AppTheme.cyan
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, linePaint);

    final dotPaint = Paint()..color = AppTheme.cyan;

    for (final point in points) {
      canvas.drawCircle(point, 4, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
