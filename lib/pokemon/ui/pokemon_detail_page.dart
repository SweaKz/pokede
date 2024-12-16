import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import '../model/pokemon_model.dart';

class PokemonDetailPage extends StatefulWidget {
  final List<PokemonModel> pokemons;
  final int currentIndex;

  const PokemonDetailPage({
    Key? key,
    required this.pokemons,
    required this.currentIndex,
  }) : super(key: key);

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  late int currentIndex;
  bool showShiny = false;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;
  }

  PokemonModel get currentPokemon => widget.pokemons[currentIndex];

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

  void nextPokemon() {
    if (currentIndex < widget.pokemons.length - 1) {
      setState(() {
        currentIndex++;
        showShiny = false;
      });
    }
  }

  void previousPokemon() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
        showShiny = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final pokemon = currentPokemon;
    final primaryType = pokemon.types.isNotEmpty ? pokemon.types[0].name : 'Normal';
    final bgColor = getColorForType(primaryType);

    final statsData = [
      pokemon.stats.hp.toDouble(),
      pokemon.stats.atk.toDouble(),
      pokemon.stats.def.toDouble(),
      pokemon.stats.speAtk.toDouble(),
      pokemon.stats.speDef.toDouble(),
      pokemon.stats.vit.toDouble(),
    ];
    final features = ["HP", "Atk", "Def", "SpA", "SpD", "Vit"];
    final ticks = const [50, 100, 150, 200, 250];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Barre supérieure
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                    ),
                    Image.asset(
                      'assets/pokeball.png',
                      width: 28,
                      height: 28,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),

              // Les 3 étoiles pour le mode shiny
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [1, 2, 3].map((i) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          showShiny = !showShiny;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Icon(
                          Icons.star,
                          color: showShiny ? Colors.yellow : Colors.white.withOpacity(0.5),
                          size: 24,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              // AnimatedSwitcher pour animer le changement de pokémon
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                key: Key(pokemon.id.toString()),
                child: Column(
                  key: ValueKey<int>(currentIndex),
                  children: [
                    // GestureDetector pour swipe horizontal
                    GestureDetector(
                      onHorizontalDragEnd: (details) {
                        if (details.primaryVelocity != null) {
                          if (details.primaryVelocity! < 0) {
                            // Swipe left => suivant
                            nextPokemon();
                          } else if (details.primaryVelocity! > 0) {
                            // Swipe right => précédent
                            previousPokemon();
                          }
                        }
                      },
                      child: Center(
                        child: Image.network(
                          showShiny ? pokemon.spriteShiny : pokemon.spriteRegular,
                          height: 250,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Nom et catégorie centrés
                    Text(
                      pokemon.nameFr,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      pokemon.category,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 8),

                    // Ligne ID + Types alignés
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Text(
                            '#${pokemon.id.toString().padLeft(3, '0')}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: pokemon.types.map((t) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Image.network(
                                  t.image,
                                  width: 30,
                                  height: 30,
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Sexe, Taille, Poids centrés
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('♂♀', style: TextStyle(fontSize: 16, color: Colors.white)),
                          const SizedBox(width: 16),
                          Text(
                            'Taille: ${pokemon.height}',
                            style: const TextStyle(fontSize: 14, color: Colors.white),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            'Poids: ${pokemon.weight}',
                            style: const TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Talents en gras
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (pokemon.talents.isNotEmpty)
                            Text(
                              'Talent: ${pokemon.talents.first.name}',
                              style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          if (pokemon.talents.length > 1)
                            Text(
                              'Talent caché: ${pokemon.talents.last.name}',
                              style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Stats
                    Text(
                      'Stats',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade900,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 250,
                            child: RadarChart.light(
                              ticks: ticks,
                              features: features,
                              data: [statsData],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 20,
                            runSpacing: 10,
                            children: [
                              Text('HP: ${pokemon.stats.hp}'),
                              Text('Atk: ${pokemon.stats.atk}'),
                              Text('Def: ${pokemon.stats.def}'),
                              Text('SpA: ${pokemon.stats.speAtk}'),
                              Text('SpD: ${pokemon.stats.speDef}'),
                              Text('Vit: ${pokemon.stats.vit}'),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Évolution
                    Text(
                      'Stade d\'évolution',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade900,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          if (pokemon.evolution.pre.isNotEmpty)
                            buildEvolutionRow(pokemon.evolution.pre),
                          if (pokemon.evolution.next.isNotEmpty)
                            buildEvolutionRow(pokemon.evolution.next),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEvolutionRow(List<PokemonEvolutionDetail> evolutionDetails) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: evolutionDetails.map((e) {
          final evoSpriteUrl = "https://raw.githubusercontent.com/Yarkis01/TyraDex/images/sprites/${e.pokedexId}/regular.png";
          return Row(
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(evoSpriteUrl),
                  ),
                  const SizedBox(height: 4),
                  Text(e.name),
                  if (e.condition.isNotEmpty) Text('(${e.condition})', style: const TextStyle(fontSize: 12))
                ],
              ),
              const SizedBox(width: 20),
            ],
          );
        }).toList(),
      ),
    );
  }
}
