import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/team_model.dart';
import '../state/app_state.dart';

class TeamsPage extends StatefulWidget {
  const TeamsPage({super.key});

  @override
  State<TeamsPage> createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  final _nameController = TextEditingController();
  final _responsibleController = TextEditingController();
  final _membersController = TextEditingController();

  static const Color background = Color(0xFF080F19);
  static const Color cardColor = Color(0xFF111E2C);
  static const Color cyan = Color(0xFF00D9FF);

  @override
  void dispose() {
    _nameController.dispose();
    _responsibleController.dispose();
    _membersController.dispose();
    super.dispose();
  }

  Future<void> _registerTeam() async {
    final name = _nameController.text.trim();
    final responsible = _responsibleController.text.trim();
    final members = _membersController.text.trim();

    if (name.isEmpty || responsible.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha o nome da equipe e o responsável.'),
        ),
      );
      return;
    }

    final team = TeamModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: name,
      responsible: responsible,
      members: members,
    );

    final success = await context.read<AppState>().addTeam(team);

    if (!mounted) return;

    if (success) {
      _nameController.clear();
      _responsibleController.clear();
      _membersController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Equipe cadastrada com sucesso!')),
      );
    }
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    int lines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: lines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: const Color(0xFF0B1521),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: cyan),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        foregroundColor: Colors.white,
        title: const Text('Equipes'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: cyan.withValues(alpha: 0.25)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.groups_rounded, color: cyan),
                      SizedBox(width: 10),
                      Text(
                        'Nova equipe',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  _field(_nameController, 'Nome da equipe'),
                  const SizedBox(height: 12),
                  _field(_responsibleController, 'Responsável'),
                  const SizedBox(height: 12),
                  _field(
                    _membersController,
                    'Integrantes (opcional)',
                    lines: 2,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _registerTeam,
                      icon: const Icon(Icons.add),
                      label: const Text('Cadastrar equipe'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: cyan,
                        foregroundColor: background,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Equipes cadastradas',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '${appState.teamCount}',
                  style: const TextStyle(color: cyan, fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (appState.teams.isEmpty)
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.groups_outlined, size: 38, color: Colors.white38),
                    SizedBox(height: 10),
                    Text(
                      'Nenhuma equipe cadastrada',
                      style: TextStyle(color: Colors.white70),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Cadastre uma equipe usando o formulário acima.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white38),
                    ),
                  ],
                ),
              ),
            ...appState.teams.map(
              (team) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.groups, color: cyan, size: 28),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            team.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Responsável: ${team.responsible}',
                            style: const TextStyle(color: Colors.white70),
                          ),
                          if (team.members.isNotEmpty) ...[
                            const SizedBox(height: 5),
                            Text(
                              'Integrantes: ${team.members}',
                              style: const TextStyle(color: Colors.white54),
                            ),
                          ],
                        ],
                      ),
                    ),
                    IconButton(
                      tooltip: 'Excluir equipe',
                      onPressed: () => appState.removeTeam(team.id),
                      icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}