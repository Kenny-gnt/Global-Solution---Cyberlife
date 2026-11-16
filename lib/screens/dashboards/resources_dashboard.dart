import 'package:flutter/material.dart';

class ResourcesDashboard extends StatelessWidget {
  const ResourcesDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'RECURSOS',
          style: TextStyle(
            color: colors.primary,
            fontSize: 12,
            letterSpacing: 3,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Monitoramento de infraestrutura',
          style: TextStyle(
            color: colors.onSurface,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Indicadores de disponibilidade e capacidade operacional.',
          style: TextStyle(
            color: colors.onSurface.withValues(alpha: 0.65),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 22),

        // INDICADORES
        _ResourceCard(
          title: 'Disponibilidade',
          value: '92%',
          description: '+4% em relação à semana anterior',
          icon: Icons.bolt_outlined,
          color: colors.primary,
        ),
        _ResourceCard(
          title: 'Pontos em atenção',
          value: '04',
          description: 'Pontos que exigem acompanhamento',
          icon: Icons.warning_amber_rounded,
          color: Colors.orangeAccent,
        ),
        _ResourceCard(
          title: 'Capacidade operacional',
          value: '76%',
          description: '+2% em relação à semana anterior',
          icon: Icons.memory_rounded,
          color: Colors.lightBlueAccent,
        ),

        const SizedBox(height: 12),

        // HISTÓRICO
        _DashboardSection(
          title: 'Histórico de disponibilidade',
          subtitle: 'Variação demonstrativa ao longo da semana',
          child: _HistoryChart(
            values: const [0.68, 0.74, 0.71, 0.82, 0.78, 0.88, 0.92],
            labels: const ['SEG', 'TER', 'QUA', 'QUI', 'SEX', 'SÁB', 'DOM'],
            color: colors.primary,
          ),
        ),

        const SizedBox(height: 18),

        // TENDÊNCIA
        _DashboardSection(
          title: 'Análise de tendência',
          subtitle: 'Comparação dos indicadores',
          child: Column(
            children: [
              _TrendRow(
                title: 'Disponibilidade',
                current: '92%',
                previous: '88%',
                color: colors.primary,
                icon: Icons.trending_up,
              ),
              const Divider(height: 24),
              _TrendRow(
                title: 'Capacidade operacional',
                current: '76%',
                previous: '74%',
                color: Colors.lightBlueAccent,
                icon: Icons.trending_up,
              ),
              const Divider(height: 24),
              _TrendRow(
                title: 'Pontos em atenção',
                current: '04',
                previous: '06',
                color: Colors.orangeAccent,
                icon: Icons.trending_down,
              ),
            ],
          ),
        ),

        const SizedBox(height: 18),

        // AVISO
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: colors.outline.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info_outline,
                color: colors.primary,
                size: 20,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Dados demonstrativos para fins acadêmicos. '
                  'Os indicadores e históricos não representam '
                  'medições reais da infraestrutura.',
                  style: TextStyle(
                    color: colors.onSurface.withValues(alpha: 0.7),
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
    );
  }
}

class _ResourceCard extends StatelessWidget {
  final String title;
  final String value;
  final String description;
  final IconData icon;
  final Color color;

  const _ResourceCard({
    required this.title,
    required this.value,
    required this.description,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha: 0.35),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 25),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: colors.onSurface,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(
                    color: colors.onSurface.withValues(alpha: 0.55),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _DashboardSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;

  const _DashboardSection({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: colors.outline.withValues(alpha: 0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: colors.onSurface,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: TextStyle(
              color: colors.onSurface.withValues(alpha: 0.55),
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 22),
          child,
        ],
      ),
    );
  }
}

class _HistoryChart extends StatelessWidget {
  final List<double> values;
  final List<String> labels;
  final Color color;

  const _HistoryChart({
    required this.values,
    required this.labels,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      height: 155,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List.generate(values.length, (index) {
          final percentage = (values[index] * 100).round();

          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Column(
                children: [
                  Text(
                    '$percentage%',
                    style: TextStyle(
                      color: colors.onSurface.withValues(alpha: 0.7),
                      fontSize: 9,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: FractionallySizedBox(
                        heightFactor: values[index],
                        widthFactor: 0.7,
                        child: Container(
                          decoration: BoxDecoration(
                            color: color.withValues(
                              alpha: index == values.length - 1 ? 1 : 0.5,
                            ),
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    labels[index],
                    style: TextStyle(
                      color: colors.onSurface.withValues(alpha: 0.55),
                      fontSize: 8,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _TrendRow extends StatelessWidget {
  final String title;
  final String current;
  final String previous;
  final Color color;
  final IconData icon;

  const _TrendRow({
    required this.title,
    required this.current,
    required this.previous,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(icon, color: color, size: 21),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: colors.onSurface,
              fontSize: 12,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              current,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Text(
              'Anterior: $previous',
              style: TextStyle(
                color: colors.onSurface.withValues(alpha: 0.5),
                fontSize: 9,
              ),
            ),
          ],
        ),
      ],
    );
  }
}