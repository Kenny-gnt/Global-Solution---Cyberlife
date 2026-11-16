import '../models/territory_model.dart';

class ApiService {
  Future<List<TerritoryModel>> fetchTerritories() async {
    await Future.delayed(const Duration(milliseconds: 700));

    // Coordenadas fictícias, utilizadas somente para demonstração visual.
    // Não representam a localização real dos trechos.
    return const [
      TerritoryModel(
        id: 'T01',
        name: 'Trecho KM 10',
        region: 'Norte',
        type: 'Rural',
        vegetationIndex: 12,
        latitude: -15.7801,
        longitude: -47.9292,
        description: 'Posição ilustrativa. Localização real não cadastrada.',
      ),
      TerritoryModel(
        id: 'T02',
        name: 'Trecho KM 25',
        region: 'Sul',
        type: 'Úmido',
        vegetationIndex: 35,
        latitude: -15.7850,
        longitude: -47.9200,
        description: 'Posição ilustrativa. Localização real não cadastrada.',
      ),
      TerritoryModel(
        id: 'T03',
        name: 'Trecho KM 40',
        region: 'Central',
        type: 'Urbano',
        vegetationIndex: 18.5,
        latitude: -15.7900,
        longitude: -47.9300,
        description: 'Posição ilustrativa. Localização real não cadastrada.',
      ),
      TerritoryModel(
        id: 'T04',
        name: 'Trecho KM 55',
        region: 'Oeste',
        type: 'Rural',
        vegetationIndex: 50,
        latitude: -15.7750,
        longitude: -47.9400,
        description: 'Posição ilustrativa. Localização real não cadastrada.',
      ),
    ];
  }
}