import 'package:equatable/equatable.dart';
import '../../filter/model/filter_model.dart';

abstract class PokemonEvent extends Equatable {
  const PokemonEvent();

  @override
  List<Object?> get props => [];
}

class LoadPokemonsWithFilter extends PokemonEvent {
  final FilterModel filter;

  const LoadPokemonsWithFilter(this.filter);

  @override
  List<Object?> get props => [filter];
}
