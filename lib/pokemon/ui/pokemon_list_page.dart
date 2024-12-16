import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../filter/model/filter_model.dart';
import '../repository/pokemon_repository.dart';
import '../bloc/pokemon_bloc.dart';
import '../bloc/pokemon_state.dart';
import '../bloc/pokemon_event.dart';
import 'pokemon_detail_page.dart';

// Fonction utilitaire pour choisir une couleur de fond selon le type principal
Color getColorForType(String type) {
  switch (type.toLowerCase()) {
    case 'fée':
      return Colors.pinkAccent.shade100;
    case 'psy':
      return Colors.purpleAccent.shade100;
    case 'électrik':
      return Colors.yellowAccent.shade700;
    case 'acier':
      return Colors.blueGrey.shade200;
    case 'roche':
      return Colors.amber.shade300;
    case 'sol':
      return Colors.orange.shade300;
    case 'spectre':
      return Colors.purple.shade300;
    case 'ténèbres':
      return Colors.grey.shade800;
    case 'dragon':
      return Colors.indigo.shade300;
    case 'combat':
      return Colors.red.shade300;
    case 'glace':
      return Colors.lightBlue.shade200;
    case 'plante':
      return Colors.green.shade300;
    case 'feu':
      return Colors.redAccent.shade200;
    case 'eau':
      return Colors.blueAccent.shade200;
    case 'insecte':
      return Colors.lightGreen.shade400;
    case 'poison':
      return Colors.purple.shade200;
    case 'vol':
      return Colors.indigo.shade200;
    case 'normal':
      return Colors.grey.shade400;
    // Ajoute d'autres types au besoin...
    default:
      return Colors.grey.shade300;
  }
}

// Widget pour afficher un type sous forme de petit badge rond
Widget buildTypeBadge(String type) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    margin: const EdgeInsets.only(right: 5, bottom: 5),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.8),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Text(
      type,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    ),
  );
}

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

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  itemCount: state.pokemons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 1.4, // Ajuste ce ratio pour avoir un rendu proche du design
                  ),
                  itemBuilder: (context, index) {
                    final pokemon = state.pokemons[index];
                    final primaryType = pokemon.types.isNotEmpty ? pokemon.types[0].name : 'Normal';
                    final bgColor = getColorForType(primaryType);

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PokemonDetailPage(
                              pokemons: state.pokemons,
                              currentIndex: index,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        color: bgColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 3,
                        child: Stack(
                          children: [
                            // Nom du Pokémon en haut à gauche
                            Positioned(
                              top: 12,
                              left: 12,
                              child: Text(
                                pokemon.nameFr,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            // ID du Pokémon en haut à droite (formaté en #XXX, par exemple)
                            Positioned(
                              top: 12,
                              right: 12,
                              child: Text(
                                '#${pokemon.id.toString().padLeft(3, '0')}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                            // Les types sous le nom, à gauche
                            Positioned(
                              top: 40,
                              left: 12,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: pokemon.types.map((t) => buildTypeBadge(t.name)).toList(),
                              ),
                            ),
                            // Le sprite du Pokémon, en bas à droite, plus petit
                            Positioned(
                              bottom: 0,
                              right: 0,
                              // On peut légèrement sortir de la carte pour un effet stylé (p.ex. right:-10, bottom:-10)
                              child: Image.network(
                                pokemon.spriteRegular,
                                width: 100, // Réduire la taille du sprite
                                fit: BoxFit.contain,
                              ),
                            ),
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
