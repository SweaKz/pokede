class FilterModel {
  final String name;
  final String backgroundImage; // Image associée à la région
  final List<int> generations;
  final String? type1; // Premier type de Pokémon
  final String? type2; // Deuxième type de Pokémon
  final int? catchRate; // Taux de capture
  final String? evolutionStage; // Stade d'évolution
  final bool? isLegendary; // Pokémon légendaire ou non

  FilterModel({
    required this.name,
    required this.backgroundImage,
    this.generations = const [],
    this.type1,
    this.type2,
    this.catchRate,
    this.evolutionStage,
    this.isLegendary,
  });
}
