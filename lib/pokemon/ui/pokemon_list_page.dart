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
    final filter = ModalRoute.of(context)!.settings.arguments as FilterModel;

    return BlocProvider(
      create: (context) => PokemonBloc(repository)..add(LoadPokemonsWithFilter(filter)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pokémons filtrés'),
        ),
        body: BlocBuilder<PokemonBloc, PokemonState>(
          builder: (context, state) {
            if (state is PokemonLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PokemonLoaded) {
              if (state.pokemons.isEmpty) {
                return const Center(child: Text('Aucun Pokémon ne correspond à ce filtre.'));
              }

              // On utilise un GridView pour afficher 2 pokémons par ligne, scrollable verticalement.
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  itemCount: state.pokemons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,            // 2 colonnes
                    crossAxisSpacing: 8.0,        // Espace horizontal entre les cartes
                    mainAxisSpacing: 8.0,         // Espace vertical entre les cartes
                    childAspectRatio: 0.8,        // Ajuster pour un meilleur rendu (hauteur/largeur)
                  ),
                  itemBuilder: (context, index) {
                    final pokemon = state.pokemons[index];
                    return InkWell(
                      onTap: () {
                        // Action à réaliser lorsqu'on sélectionne un Pokémon
                        // Plus tard : naviguer vers une page de détails, etc.
                      },
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Image.network(
                                pokemon.spriteRegular,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Expanded(
                              flex: 1,
                              child: Text(
                                pokemon.nameFr,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    );
                  },
                ),
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
