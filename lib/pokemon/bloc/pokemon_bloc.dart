import 'package:flutter_bloc/flutter_bloc.dart';
import 'pokemon_event.dart';
import 'pokemon_state.dart';
import '../repository/pokemon_repository.dart';
import '../model/pokemon_model.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonRepository repository;

  PokemonBloc(this.repository) : super(const PokemonLoading()) {
    on<LoadPokemonsWithFilter>(_onLoadPokemonsWithFilter);
  }

  Future<void> _onLoadPokemonsWithFilter(
      LoadPokemonsWithFilter event, Emitter<PokemonState> emit) async {
    emit(const PokemonLoading());
    try {
      // Récupérer tous les Pokémon
      final allPokemons = await repository.loadAllPokemons();

      // Appliquer le filtre. Par exemple, si filter.generations contient [1],
      // on ne garde que les Pokémon de la génération 1.
      List<PokemonModel> filteredPokemons = allPokemons;
      
      // Si le filtre a des générations définies
      if (event.filter.generations.isNotEmpty) {
        filteredPokemons = filteredPokemons.where((p) => 
          event.filter.generations.contains(p.generation)
        ).toList();
      }

      // Ici plus tard, on pourra filtrer par type, catchRate, etc.
      // Pour l'instant on se limite à la génération.

      emit(PokemonLoaded(filteredPokemons));
    } catch (e) {
      emit(PokemonError(e.toString()));
    }
  }
}
