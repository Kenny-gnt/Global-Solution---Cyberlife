import 'package:flutter/material.dart';

class ClimateDashboard extends StatelessWidget {
  const ClimateDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'CLIMA',
          style: TextStyle(
            color: colors.primary,
            fontSize: 12,
            letterSpacing: 3,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Condições ambientais',
          style: TextStyle(
            color: colors.onSurface,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Indicadores ambientais e variações climáticas.',
          style: TextStyle(
            color: colors.onSurface.withValues(alpha: 0.65),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 22),

        // CONDIÇÃO DEMONSTRATIVA
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: colors.primary.withValues(alpha: 0.3),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.cloud_outlined,
                color: colors.primary,
                size: 42,
              ),
              const SizedBox(height: 12),
              Text(
                '22°C',
                style: TextStyle(
                  color: colors.onSurface,
                  fontSize: 42,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                'Chuva leve',
                style: TextStyle(
                  color: colors.onSurface.withValues(alpha: 0.7),
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 20),
              const Divider(color: Colors.white12),
              const SizedBox(height: 10),
              const _ClimateInfo(label: 'Umidade', value: '78%'),
              const _ClimateInfo(
                label: 'Probabilidade de chuva',
                value: '65%',
              ),
              const _ClimateInfo(label: 'Vento', value: '12 km/h'),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // HISTÓRICO DE TEMPERATURA
        _ClimateSection(
          title: 'Histórico de temperatura',
          subtitle: 'Variação demonstrativa durante a semana',
          child: _ClimateChart(
            values: const [19, 21, 20, 23, 24, 21, 22],
            labels: const ['SEG', 'TER', 'QUA', 'QUI', 'SEX', 'SÁB', 'DOM'],
            color: Colors.orangeAccent,
          ),
        ),

        const SizedBox(height: 18),

        // INDICADORES AMBIENTAIS
        _ClimateSection(
          title: 'Indicadores ambientais',
          subtitle: 'Comparação dos valores registrados',
          child: Column(
            children: [
              _ClimateBar(
                label: 'Umidade',
                value: 0.78,
                display: '78%',
                color: Colors.lightBlueAccent,
              ),
              const SizedBox(height: 18),
              _ClimateBar(
                label: 'Probabilidade de chuva',
                value: 0.65,
                display: '65%',
                color: colors.primary,
              ),
              const SizedBox(height: 18),
              _ClimateBar(
                label: 'Intensidade do vento',
                value: 0.40,
                display: '12 km/h',
                color: Colors.orangeAccent,
              ),
            ],
          ),
        ),

        const SizedBox(height: 18),

        // TENDÊNCIA
        _ClimateSection(
          title: 'Tendência semanal',
          subtitle: 'Comparação demonstrativa com a semana anterior',
          child: const Column(
            children: [
              _ClimateTrend(
                label: 'Temperatura média',
                value: '+2°C',
                icon: Icons.trending_up,
              ),
              Divider(height: 24),
              _ClimateTrend(
                label: 'Umidade',
                value: '-3%',
                icon: Icons.trending_down,
              ),
              Divider(height: 24),
              _ClimateTrend(
                label: 'Probabilidade de chuva',
                value: '+5%',
                icon: Icons.trending_up,
              ),
            ],
          ),
        ),

        const SizedBox(height: 18),

        // TRANSPARÊNCIA
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
                  'Dados climáticos simulados para demonstração acadêmica. '
                  'Não representam condições meteorológicas em tempo real '
                  'e não devem orientar decisões operacionais.',
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

class _ClimateInfo extends StatelessWidget {
  final String label;
  final String value;

  const _ClimateInfo({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: colors.onSurface.withValues(alpha: 0.65),
                fontSize: 12,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: colors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _ClimateSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;

  const _ClimateSection({
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

class _ClimateChart extends StatelessWidget {
  final List<double> values;
  final List<String> labels;
  final Color color;

  const _ClimateChart({
    required this.values,
    required this.labels,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final maxValue = values.reduce((a, b) => a > b ? a : b);

    return SizedBox(
      height: 150,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List.generate(values.length, (index) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Column(
                children: [
                  Text(
                    '${values[index].round()}°',
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
                        heightFactor: values[index] / maxValue,
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

class _ClimateBar extends StatelessWidget {
  final String label;
  final double value;
  final String display;
  final Color color;

  const _ClimateBar({
    required this.label,
    required this.value,
    required this.display,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                color: colors.onSurface,
                fontSize: 12,
              ),
            ),
            Text(
              display,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 7,
            backgroundColor: colors.onSurface.withValues(alpha: 0.1),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}

class _ClimateTrend extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _ClimateTrend({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(icon, color: colors.primary, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: colors.onSurface,
              fontSize: 12,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: colors.primary,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}