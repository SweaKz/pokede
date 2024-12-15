import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../filter/bloc/filter_bloc.dart';
import '../../filter/bloc/filter_state.dart';

class PokemonListPage extends StatelessWidget {
  const PokemonListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pokémon filtrés")),
      body: BlocBuilder<FilterBloc, FilterState>(
        builder: (context, state) {
          if (state is FiltersLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FilteredPokemonsLoaded) {
            final pokemons = state.pokemons;

            return ListView.builder(
              itemCount: pokemons.length,
              itemBuilder: (context, index) {
                final pokemon = pokemons[index];
                return ListTile(
                  leading: Image.network(pokemon['sprites']['regular']),
                  title: Text(pokemon['name']['fr']),
                  subtitle: Text("ID : ${pokemon['pokedex_id']}"),
                );
              },
            );
          } else {
            return const Center(child: Text("Aucun Pokémon trouvé."));
          }
        },
      ),
    );
  }
}
