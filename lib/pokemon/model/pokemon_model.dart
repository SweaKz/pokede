class PokemonModel {
  final int id;
  final int generation;
  final String category;
  final String nameFr;
  final String spriteRegular;
  final String spriteShiny;
  final List<PokemonType> types;
  final List<PokemonTalent> talents;
  final PokemonStats stats;
  final List<PokemonResistance> resistances;
  final PokemonEvolution evolution;
  final int catchRate;
  final String height;
  final String weight;
  final double maleRate;
  final double femaleRate;

  const PokemonModel({
    required this.id,
    required this.generation,
    required this.category,
    required this.nameFr,
    required this.spriteRegular,
    required this.spriteShiny,
    required this.types,
    required this.talents,
    required this.stats,
    required this.resistances,
    required this.evolution,
    required this.catchRate,
    required this.height,
    required this.weight,
    required this.maleRate,
    required this.femaleRate,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    final nameJson = Map<String, dynamic>.from(json['name'] ?? {});
    final spritesJson = Map<String, dynamic>.from(json['sprites'] ?? {});
    final typesJson = json['types'] ?? [];
    final statsJson = Map<String, dynamic>.from(json['stats'] ?? {});
    final resistancesJson = json['resistances'] ?? [];
    final evolutionJson = Map<String, dynamic>.from(json['evolution'] ?? {});
    final talentsJson = json['talents'] ?? [];
    final sexeJson = json['sexe'] ?? {};

    return PokemonModel(
      id: (json['pokedex_id'] as int?) ?? 0, // Valeur par défaut si null
      generation: (json['generation'] as int?) ?? 0,
      category: (json['category'] as String?) ?? 'Inconnu',
      nameFr: (nameJson['fr'] ?? '') as String,
      spriteRegular: (spritesJson['regular'] ?? '') as String,
      spriteShiny: (spritesJson['shiny'] ?? '') as String,
      types: (typesJson as List)
          .map((t) => PokemonType.fromJson(Map<String, dynamic>.from(t)))
          .toList(),
      talents: (talentsJson as List)
          .map((t) => PokemonTalent.fromJson(Map<String, dynamic>.from(t)))
          .toList(),
      stats: PokemonStats.fromJson(statsJson),
      resistances: (resistancesJson as List)
          .map((r) => PokemonResistance.fromJson(Map<String, dynamic>.from(r)))
          .toList(),
      evolution: PokemonEvolution.fromJson(evolutionJson),
      catchRate: (json['catch_rate'] as int?) ?? 0,
      height: json['height']?.toString() ?? '',
      weight: json['weight']?.toString() ?? '',
      maleRate: (sexeJson['male'] is num) ? (sexeJson['male'] as num).toDouble() : 0.0,
      femaleRate: (sexeJson['female'] is num) ? (sexeJson['female'] as num).toDouble() : 0.0,
    );
  }
}

class PokemonType {
  final String name;
  final String image;

  const PokemonType({
    required this.name,
    required this.image,
  });

  factory PokemonType.fromJson(Map<String, dynamic> json) {
    return PokemonType(
      name: json['name'] as String,
      image: json['image'] as String,
    );
  }
}

class PokemonTalent {
  final String name;
  final bool tc;

  const PokemonTalent({
    required this.name,
    required this.tc,
  });

  factory PokemonTalent.fromJson(Map<String, dynamic> json) {
    return PokemonTalent(
      name: (json['name'] as String?) ?? '',
      tc: (json['tc'] as bool?) ?? false,
    );
  }
}

class PokemonStats {
  final int hp;
  final int atk;
  final int def;
  final int speAtk;
  final int speDef;
  final int vit;

  const PokemonStats({
    required this.hp,
    required this.atk,
    required this.def,
    required this.speAtk,
    required this.speDef,
    required this.vit,
  });

  factory PokemonStats.fromJson(Map<String, dynamic> json) {
    return PokemonStats(
      hp: json['hp'] as int,
      atk: json['atk'] as int,
      def: json['def'] as int,
      speAtk: json['spe_atk'] as int,
      speDef: json['spe_def'] as int,
      vit: json['vit'] as int,
    );
  }
}

class PokemonResistance {
  final String name;
  final double multiplier;

  const PokemonResistance({
    required this.name,
    required this.multiplier,
  });

  factory PokemonResistance.fromJson(Map<String, dynamic> json) {
    final mult = json['multiplier'];
    return PokemonResistance(
      name: json['name'] as String,
      multiplier: (mult is int) ? mult.toDouble() : mult as double,
    );
  }
}

class PokemonEvolution {
  final List<PokemonEvolutionDetail> pre;
  final List<PokemonEvolutionDetail> next;
  final List<PokemonEvolutionDetail> mega;

  const PokemonEvolution({
    required this.pre,
    required this.next,
    required this.mega,
  });

  factory PokemonEvolution.fromJson(Map<String, dynamic> json) {
    final preJson = json['pre'] ?? [];
    final nextJson = json['next'] ?? [];
    final megaJson = json['mega'] ?? [];

    return PokemonEvolution(
      pre: (preJson as List)
          .map((e) => PokemonEvolutionDetail.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
      next: (nextJson as List)
          .map((e) => PokemonEvolutionDetail.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
      mega: (megaJson as List)
          .map((e) => PokemonEvolutionDetail.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
    );
  }
}

class PokemonEvolutionDetail {
  final int pokedexId;
  final String name;
  final String condition;

  const PokemonEvolutionDetail({
    required this.pokedexId,
    required this.name,
    required this.condition,
  });

  factory PokemonEvolutionDetail.fromJson(Map<String, dynamic> json) {
    return PokemonEvolutionDetail(
      pokedexId: (json['pokedex_id'] as num?)?.toInt() ?? 0,
      name: (json['name'] as String?) ?? '',
      condition: (json['condition'] as String?) ?? '',
    );
  }
}
