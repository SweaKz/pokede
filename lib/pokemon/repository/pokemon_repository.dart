import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import '../model/pokemon_model.dart';

class PokemonRepository {
  // Le fichier local contenant tous les Pokémon, adapté selon l’emplacement réel du fichier
  static const String _localJsonFile = 'assets/pokemon/pokemon.json';

  /// Cette méthode charge la liste complète des Pokémon à partir du JSON local.
  Future<List<PokemonModel>> loadAllPokemons() async {
    // Lecture du fichier JSON à partir des assets
    final jsonString = await rootBundle.loadString(_localJsonFile);
    final data = jsonDecode(jsonString);

    if (data is List) {
      // Conversion explicite en Map<String, dynamic> pour chaque élément
      return data.map((e) {
        final map = Map<String, dynamic>.from(e);
        return PokemonModel.fromJson(map);
      }).toList();
    } else {
      throw Exception('Le fichier JSON ne contient pas une liste valide.');
    }
  }
}
