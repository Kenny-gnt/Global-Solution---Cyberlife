import 'package:flutter/material.dart';

class ServicesDashboard extends StatelessWidget {
  const ServicesDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'SERVIÇOS',
          style: TextStyle(
            color: colors.primary,
            fontSize: 12,
            letterSpacing: 3,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Atendimento e infraestrutura',
          style: TextStyle(
            color: colors.onSurface,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Acompanhamento dos atendimentos e demandas territoriais.',
          style: TextStyle(
            color: colors.onSurface.withValues(alpha: 0.65),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 22),

        // INDICADORES
        const _ServiceCard(
          icon: Icons.support_agent,
          title: 'Atendimentos',
          value: '186',
          description: 'Registros no período',
          color: Colors.lightBlueAccent,
        ),
        const _ServiceCard(
          icon: Icons.pending_actions,
          title: 'Pendências',
          value: '12',
          description: 'Aguardando avaliação',
          color: Colors.orangeAccent,
        ),
        const _ServiceCard(
          icon: Icons.check_circle_outline,
          title: 'Concluídos',
          value: '174',
          description: 'Atendimentos finalizados',
          color: Colors.greenAccent,
        ),

        const SizedBox(height: 10),

        // TAXA DE CONCLUSÃO
        _ServiceSection(
          title: 'Taxa de conclusão',
          subtitle: 'Proporção de atendimentos finalizados',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '93,5%',
                    style: TextStyle(
                      color: colors.primary,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '174 de 186',
                    style: TextStyle(
                      color: colors.onSurface.withValues(alpha: 0.6),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: const LinearProgressIndicator(
                  value: 174 / 186,
                  minHeight: 10,
                  backgroundColor: Colors.white12,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.greenAccent,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 18),

        // HISTÓRICO
        _ServiceSection(
          title: 'Histórico de atendimentos',
          subtitle: 'Quantidade demonstrativa por dia da semana',
          child: const _ServiceChart(
            values: [18, 24, 20, 32, 28, 35, 29],
            labels: ['SEG', 'TER', 'QUA', 'QUI', 'SEX', 'SÁB', 'DOM'],
          ),
        ),

        const SizedBox(height: 18),

        // TENDÊNCIAS
        _ServiceSection(
          title: 'Análise de desempenho',
          subtitle: 'Comparação demonstrativa com o período anterior',
          child: const Column(
            children: [
              _ServiceTrend(
                title: 'Atendimentos',
                value: '+12%',
                icon: Icons.trending_up,
                color: Colors.lightBlueAccent,
              ),
              Divider(height: 24),
              _ServiceTrend(
                title: 'Pendências',
                value: '-8%',
                icon: Icons.trending_down,
                color: Colors.greenAccent,
              ),
              Divider(height: 24),
              _ServiceTrend(
                title: 'Conclusões',
                value: '+15%',
                icon: Icons.trending_up,
                color: Colors.greenAccent,
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
                  'Indicadores e históricos simulados para demonstração '
                  'acadêmica. Não representam registros reais de serviços.',
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

class _ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String description;
  final Color color;

  const _ServiceCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.description,
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
          color: color.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 27),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: colors.onSurface,
                    fontSize: 13,
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
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;

  const _ServiceSection({
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

class _ServiceChart extends StatelessWidget {
  final List<double> values;
  final List<String> labels;

  const _ServiceChart({
    required this.values,
    required this.labels,
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
                    values[index].round().toString(),
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
                            color: colors.primary.withValues(
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

class _ServiceTrend extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _ServiceTrend({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(icon, color: color, size: 20),
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
        Text(
          value,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}