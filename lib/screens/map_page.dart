import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../models/alert_model.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng? _userPosition;
  bool _loadingLocation = false;

  Color _priorityColor(AlertPriority priority) {
    switch (priority) {
      case AlertPriority.urgent:
        return AppTheme.danger;
      case AlertPriority.critical:
        return AppTheme.magenta;
      case AlertPriority.attention:
        return AppTheme.warning;
      case AlertPriority.normal:
        return AppTheme.success;
    }
  }

  String _priorityLabel(AlertPriority priority) {
    switch (priority) {
      case AlertPriority.urgent:
        return 'Urgente';
      case AlertPriority.critical:
        return 'Crítico';
      case AlertPriority.attention:
        return 'Atenção';
      case AlertPriority.normal:
        return 'Normal';
    }
  }

  AlertPriority _territoryPriority(
    String territoryId,
    AppState appState,
  ) {
    final alerts = appState.alerts
        .where((alert) => alert.territoryId == territoryId)
        .toList();

    if (alerts.isEmpty) return AlertPriority.normal;

    const order = {
      AlertPriority.normal: 0,
      AlertPriority.attention: 1,
      AlertPriority.critical: 2,
      AlertPriority.urgent: 3,
    };

    alerts.sort(
      (a, b) => order[b.priority]!.compareTo(order[a.priority]!),
    );

    return alerts.first.priority;
  }

  Future<void> _goToMyLocation() async {
    setState(() => _loadingLocation = true);

    try {
      final serviceEnabled =
          await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        throw Exception('Ative o serviço de localização do dispositivo.');
      }

      LocationPermission permission =
          await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        throw Exception('Permissão de localização não concedida.');
      }

      final position = await Geolocator.getCurrentPosition();

      if (!mounted) return;

      setState(() {
        _userPosition = LatLng(
          position.latitude,
          position.longitude,
        );
      });
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceFirst('Exception: ', ''))),
      );
    } finally {
      if (mounted) {
        setState(() => _loadingLocation = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    final territories = appState.territories
        .where((territory) => territory.hasCoordinates)
        .toList();

    final initialCenter = _userPosition ??
        (territories.isNotEmpty
            ? LatLng(
                territories.first.latitude!,
                territories.first.longitude!,
              )
            : const LatLng(-14.235, -51.925));

    final markers = territories.map((territory) {
      final priority = _territoryPriority(territory.id, appState);
      final color = _priorityColor(priority);

      return Marker(
        point: LatLng(
          territory.latitude!,
          territory.longitude!,
        ),
        width: 110,
        height: 75,
        child: GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: const Color(0xFF101B29),
              builder: (context) => Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      territory.name,
                      style: const TextStyle(
                        color: AppTheme.text,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      territory.region,
                      style: const TextStyle(color: AppTheme.muted),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Icon(Icons.circle, color: color, size: 12),
                        const SizedBox(width: 8),
                        Text(
                          _priorityLabel(priority),
                          style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Índice de vegetação: ${territory.vegetationIndex}',
                      style: const TextStyle(color: AppTheme.text),
                    ),
                  ],
                ),
              ),
            );
          },
          child: Column(
            children: [
              Icon(
                Icons.location_on,
                color: color,
                size: 38,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 7,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF101B29),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: color),
                ),
                child: Text(
                  territory.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppTheme.text,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa territorial'),
        actions: [
          IconButton(
            onPressed: _loadingLocation ? null : _goToMyLocation,
            tooltip: 'Minha localização',
            icon: _loadingLocation
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.my_location, color: AppTheme.cyan),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'DISTRIBUIÇÃO TERRITORIAL',
              style: TextStyle(
                color: AppTheme.cyan,
                fontSize: 11,
                letterSpacing: 1.5,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Visualização geográfica dos trechos monitorados',
              style: TextStyle(color: AppTheme.muted, fontSize: 12),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Stack(
                  children: [
                    FlutterMap(
                      key: ValueKey(
                        '${initialCenter.latitude}_${initialCenter.longitude}',
                      ),
                      options: MapOptions(
                        initialCenter: initialCenter,
                        initialZoom: territories.isEmpty ? 4.5 : 13,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.cyberlife',
                        ),
                        MarkerLayer(markers: markers),
                        if (_userPosition != null)
                          MarkerLayer(
                            markers: [
                              Marker(
                                point: _userPosition!,
                                width: 40,
                                height: 40,
                                child: const Icon(
                                  Icons.my_location,
                                  color: AppTheme.cyan,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                    if (territories.isEmpty)
                      Positioned(
                        left: 12,
                        right: 12,
                        bottom: 12,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF101B29),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Nenhum trecho possui coordenadas cadastradas. '
                            'Os marcadores aparecerão quando houver localização disponível.',
                            style: TextStyle(
                              color: AppTheme.text,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF101B29),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppTheme.line),
              ),
              child: Wrap(
                spacing: 18,
                runSpacing: 12,
                children: [
                  _Legend(color: AppTheme.danger, label: 'Urgente'),
                  _Legend(color: AppTheme.magenta, label: 'Crítico'),
                  _Legend(color: AppTheme.warning, label: 'Atenção'),
                  _Legend(color: AppTheme.success, label: 'Normal'),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '${territories.length} trecho(s) com coordenadas cadastradas',
              style: const TextStyle(
                color: AppTheme.muted,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final Color color;
  final String label;

  const _Legend({
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.circle, color: color, size: 10),
        const SizedBox(width: 7),
        Text(
          label,
          style: const TextStyle(
            color: AppTheme.text,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}