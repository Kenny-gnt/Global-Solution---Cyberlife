import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/occurrence_model.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/cyber_components.dart';

class OccurrencePage extends StatefulWidget {
  const OccurrencePage({super.key});

  @override
  State<OccurrencePage> createState() => _OccurrencePageState();
}

class _OccurrencePageState extends State<OccurrencePage> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();

  String selectedType = 'Vegetação';
  String selectedPriority = 'Atenção';
  String? selectedTerritoryId;

  bool isSaving = false;

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _registerOccurrence() async {
    if (!_formKey.currentState!.validate()) return;

    final appState = context.read<AppState>();

    setState(() => isSaving = true);

    final occurrence = OccurrenceModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      territoryId: selectedTerritoryId!,
      type: selectedType,
      description: _descriptionController.text.trim(),
      createdAt: DateTime.now(),
      status: 'Em análise',
      priority: selectedPriority,
    );

    try {
      final success = await appState.addOccurrence(occurrence);

      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ocorrência registrada com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );

        _descriptionController.clear();

        setState(() {
          selectedType = 'Vegetação';
          selectedPriority = 'Atenção';
          selectedTerritoryId = null;
        });

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Não foi possível registrar a ocorrência.'),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final territories = context.watch<AppState>().territories;

    final validTerritoryId = territories.any(
      (territory) => territory.id == selectedTerritoryId,
    )
        ? selectedTerritoryId
        : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova ocorrência'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SectionTitle(
              title: 'Registrar evento',
              subtitle: 'Informe os dados da ocorrência identificada',
            ),
            const SizedBox(height: 22),

            const Text(
              'Tipo de ocorrência',
              style: TextStyle(color: AppTheme.text, fontSize: 12),
            ),
            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              initialValue: selectedType,
              dropdownColor: AppTheme.surface,
              items: ['Vegetação', 'Clima', 'Infraestrutura', 'Outro']
                  .map(
                    (item) => DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => selectedType = value);
                }
              },
            ),

            const SizedBox(height: 18),

            const Text(
              'Trecho / Território',
              style: TextStyle(color: AppTheme.text, fontSize: 12),
            ),
            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              initialValue: validTerritoryId,
              dropdownColor: AppTheme.surface,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.location_on_outlined),
                hintText: 'Selecione um território',
              ),
              items: territories.map((territory) {
                return DropdownMenuItem<String>(
                  value: territory.id,
                  child: Text(
                    '${territory.name} - ${territory.region}',
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() => selectedTerritoryId = value);
              },
              validator: (value) {
                if (value == null) {
                  return territories.isEmpty
                      ? 'Nenhum território disponível.'
                      : 'Selecione um território.';
                }
                return null;
              },
            ),

            const SizedBox(height: 18),

            const Text(
              'Prioridade',
              style: TextStyle(color: AppTheme.text, fontSize: 12),
            ),
            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              initialValue: selectedPriority,
              dropdownColor: AppTheme.surface,
              items: ['Urgente', 'Crítico', 'Atenção', 'Normal']
                  .map(
                    (item) => DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => selectedPriority = value);
                }
              },
            ),

            const SizedBox(height: 18),

            const Text(
              'Descrição',
              style: TextStyle(color: AppTheme.text, fontSize: 12),
            ),
            const SizedBox(height: 8),

            TextFormField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Descreva o que foi identificado...',
                alignLabelWithHint: true,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Descreva a ocorrência.';
                }

                if (value.trim().length < 5) {
                  return 'Descreva um pouco mais a ocorrência.';
                }

                return null;
              },
            ),

            const SizedBox(height: 25),

            SizedBox(
              height: 52,
              child: FilledButton.icon(
                onPressed: isSaving ? null : _registerOccurrence,
                icon: isSaving
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(Icons.add_circle_outline),
                label: Text(
                  isSaving ? 'Salvando...' : 'Registrar ocorrência',
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: AppTheme.cyan,
                  foregroundColor: AppTheme.background,
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}