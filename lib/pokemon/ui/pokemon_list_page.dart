import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../filter/model/filter_model.dart';
import '../repository/pokemon_repository.dart';
import '../bloc/pokemon_bloc.dart';
import '../bloc/pokemon_state.dart';
import '../bloc/pokemon_event.dart';

class PokemonListPage extends StatelessWidget {
  final PokemonRepository repository;
  const PokemonListPage({Key? key, required this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Récupère le filtre envoyé en arguments
    final filter = ModalRoute.of(context)!.settings.arguments as FilterModel;

    return BlocProvider(
      create: (context) => PokemonBloc(repository)..add(LoadPokemonsWithFilter(filter)),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Pokémons filtrés'),
        ),
        body: BlocBuilder<PokemonBloc, PokemonState>(
          builder: (context, state) {
            if (state is PokemonLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PokemonLoaded) {
              if (state.pokemons.isEmpty) {
                return const Center(child: Text('Aucun Pokémon ne correspond à ce filtre.'));
              }
              return ListView.builder(
                itemCount: state.pokemons.length,
                itemBuilder: (context, index) {
                  final pokemon = state.pokemons[index];
                  return ListTile(
                    title: Text(pokemon.nameFr),
                  );
                },
              );
            } else if (state is PokemonError) {
              return Center(child: Text('Erreur: ${state.message}'));
            } else {
              return const Center(child: Text('État inconnu'));
            }
          },
        ),
      ),
    );
  }
}
