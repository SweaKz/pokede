import 'package:flutter/material.dart';
import '../model/pokemon_model.dart';

class PokemonDetailPage extends StatefulWidget {
  final PokemonModel pokemon;
  const PokemonDetailPage({super.key, required this.pokemon});

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this); 
    // 3 tabs par exemple : About, Base Stats, Evolution
    // Tu peux en rajouter un pour Moves : length: 4
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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

  Widget buildTypeBadge(String type) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        type,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pokemon = widget.pokemon;
    final primaryType = pokemon.types.isNotEmpty ? pokemon.types[0].name : 'Normal';
    final bgColor = getColorForType(primaryType);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Stack(
          children: [
            // Contenu principal
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bouton retour et favori en haut
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                      ),
                      const Icon(Icons.favorite_border, color: Colors.white, size: 28),
                    ],
                  ),
                ),
                // Nom du Pokémon et ID
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          pokemon.nameFr,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        '#${pokemon.id.toString().padLeft(3, '0')}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // Types du Pokémon
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: pokemon.types.map((t) => buildTypeBadge(t.name)).toList(),
                  ),
                ),
                // Catégorie
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Text(
                    pokemon.category,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ),
                // Spacer pour laisser la place au Pokémon
                const SizedBox(height: 16),

                // Image du Pokémon au milieu
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  alignment: Alignment.center,
                  child: Image.network(
                  pokemon.spriteRegular,
                  width: 400,
                  fit: BoxFit.contain,
                  ),
                ),
                ],
            ),

            // Le container blanc arrondi en bas avec tabs
            DraggableScrollableSheet(
              initialChildSize: 0.4,
              minChildSize: 0.3,
              maxChildSize: 0.85,
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Barre d'onglets
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: TabBar(
                          controller: _tabController,
                          indicatorColor: Colors.blueAccent,
                          labelColor: Colors.black87,
                          unselectedLabelColor: Colors.grey,
                          tabs: const [
                            Tab(text: 'A propos'),
                            Tab(text: 'Stats de base'),
                            Tab(text: 'Evolution'),
                            // Ajoute une autre tab si besoin (Moves)
                            // Tab(text: 'Moves'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            // ABOUT TAB
                            SingleChildScrollView(
                              controller: scrollController,
                              padding: const EdgeInsets.all(16),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'A propos',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Description basique du Pokémon, son habitat, ses habitudes, etc.",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  SizedBox(height: 16),
                                  // Info sur la taille, le poids, etc.
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          Text('Hauteur', style: TextStyle(fontWeight: FontWeight.bold)),
                                          SizedBox(height: 4),
                                          Text("2' 04\""), // Valeurs à adapter si on les a
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text('Poids', style: TextStyle(fontWeight: FontWeight.bold)),
                                          SizedBox(height: 4),
                                          Text("15.2 lbs"), // Valeurs à adapter
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 24),
                                  // Breeding, Egg Groups, etc.
                                  Text(
                                    'Breeding',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 8),
                                  Text("Gender : 87.5% male / 12.5% female"),
                                  Text("Egg Groups: Monster, Grass"),
                                  Text("Egg Cycle: ..."),
                                ],
                              ),
                            ),

                            // BASE STATS TAB
                            SingleChildScrollView(
                              controller: scrollController,
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Base Stats',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 8),
                                  // Affiche les stats du Pokémon (HP, Atk, Def, etc.)
                                  buildStatRow('HP', pokemon.stats.hp),
                                  buildStatRow('Attack', pokemon.stats.atk),
                                  buildStatRow('Defense', pokemon.stats.def),
                                  buildStatRow('Sp. Atk', pokemon.stats.speAtk),
                                  buildStatRow('Sp. Def', pokemon.stats.speDef),
                                  buildStatRow('Speed', pokemon.stats.vit),
                                  const SizedBox(height: 16),
                                  const Text(
                                    'Type defenses',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 8),
                                  // Affiche les resistances du Pokémon
                                  Wrap(
                                    spacing: 6,
                                    runSpacing: 6,
                                    children: pokemon.resistances.map((res) {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          "${res.name} x${res.multiplier}",
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),

                            // EVOLUTION TAB
                            SingleChildScrollView(
                              controller: scrollController,
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Evolution Chain',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 8),
                                  // Affiche la chaîne d'évolution (pre, next, etc.)
                                  // Exemple simplifié: afficher les évolutions pré et next
                                  if (pokemon.evolution.pre.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: Text("Previous: ${pokemon.evolution.pre.map((e) => e.name).join(', ')}"),
                                    ),
                                  if (pokemon.evolution.next.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: Text("Next: ${pokemon.evolution.next.map((e) => e.name).join(', ')}"),
                                    ),
                                  // Ici tu peux agrémenter avec des images, des flèches, etc.
                                ],
                              ),
                            ),

                            // Si tu rajoutes Moves, ajoute un 4e enfant ici
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStatRow(String statName, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 60, child: Text(statName)),
          const SizedBox(width: 8),
          SizedBox(width: 30, child: Text(value.toString())),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 6,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(3),
              ),
              width: (value / 100) * MediaQuery.of(context).size.width * 0.4, // barre proportionnelle
            ),
          )
        ],
      ),
    );
  }
}
