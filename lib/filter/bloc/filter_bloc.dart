import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../model/filter_model.dart';
import '../bloc/filter_event.dart';
import '../bloc/filter_state.dart';
import '../util/local_storage_helper.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  List<dynamic> pokemonData = []; // Données Pokémon en mémoire

  FilterBloc() : super(FiltersLoading()) {
    on<LoadDefaultFilters>(_onLoadDefaultFilters);
    on<ApplyFilter>(_onApplyFilter);
  }

  // Filtres par défaut
  final List<FilterModel> defaultFilters = [
    FilterModel(name: "Kanto (1G)", backgroundImage: "assets/region/region-kanto.png", generations: [1]),
    FilterModel(name: "Johto (2G)", backgroundImage: "assets/region/region-johto.png", generations: [2]),
    FilterModel(name: "Hoenn (3G)", backgroundImage: "assets/region/region-hoenn.png", generations: [3]),
    FilterModel(name: "Sinnoh (4G) / Hisui", backgroundImage: "assets/region/region-sinnoh.png", generations: [4]),
    FilterModel(name: "Unys (5G)", backgroundImage: "assets/region/region-unys.png", generations: [5]),
  ];

  // Charge les filtres par défaut + les données Pokémon
  Future<void> _onLoadDefaultFilters(
    LoadDefaultFilters event, Emitter<FilterState> emit) async {
  emit(FiltersLoading());

  try {
    // Vérifiez si le fichier existe
    if (await LocalStorageHelper.doesFileExist()) {
      pokemonData = await LocalStorageHelper.readFromFile();
      if (pokemonData.isEmpty) {
        throw Exception("Le fichier local est vide.");
      }
    } else {
      // Appel API pour récupérer les Pokémon
      final response = await http.get(Uri.parse("https://votre-api.com/pokemons"));
      if (response.statusCode == 200) {
        pokemonData = jsonDecode(response.body);
        if (pokemonData.isEmpty) {
          throw Exception("Les données reçues de l'API sont vides.");
        }
        await LocalStorageHelper.writeToFile(jsonEncode(pokemonData));
      } else {
        throw Exception("Échec de l'appel à l'API.");
      }
    }

    // Émettez les filtres par défaut
    emit(FiltersLoaded(defaultFilters));
  } catch (e) {
    emit(FilterError("Erreur : ${e.toString()}"));
  }
}


  // Applique les filtres sur les données Pokémon
  void _onApplyFilter(ApplyFilter event, Emitter<FilterState> emit) {
  emit(FiltersLoading());
  try {
    final filteredPokemons = pokemonData.where((pokemon) {
      final type1Match = event.filter.type1 == null ||
          (pokemon['types']?.isNotEmpty == true &&
           pokemon['types'][0]['name'] == event.filter.type1);
      final type2Match = event.filter.type2 == null ||
          (pokemon['types']?.length > 1 &&
           pokemon['types'][1]['name'] == event.filter.type2);
      final generationMatch = event.filter.generations.isEmpty ||
          (pokemon['generation'] != null &&
           event.filter.generations.contains(pokemon['generation']));

      return type1Match && type2Match && generationMatch;
    }).toList();

    emit(FilteredPokemonsLoaded(filteredPokemons));
  } catch (e) {
    emit(FilterError("Erreur lors de l'application des filtres : ${e.toString()}"));
  }
}
}