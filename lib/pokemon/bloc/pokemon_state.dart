import 'package:equatable/equatable.dart';
import '../model/pokemon_model.dart';

abstract class PokemonState extends Equatable {
  const PokemonState();

  @override
  List<Object?> get props => [];
}

class PokemonLoading extends PokemonState {
  const PokemonLoading();
}

class PokemonLoaded extends PokemonState {
  final List<PokemonModel> pokemons;

  const PokemonLoaded(this.pokemons);

  @override
  List<Object?> get props => [pokemons];
}

class PokemonError extends PokemonState {
  final String message;
  const PokemonError(this.message);

  @override
  List<Object?> get props => [message];
}
