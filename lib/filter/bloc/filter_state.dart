import 'package:equatable/equatable.dart';

import '../model/filter_model.dart';

abstract class FilterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FiltersLoading extends FilterState {}

class FiltersLoaded extends FilterState {
  final List<FilterModel> filters;

  FiltersLoaded(this.filters);

  @override
  List<Object?> get props => [filters];
}

class FilteredPokemonsLoaded extends FilterState {
  final List<dynamic> pokemons;

  FilteredPokemonsLoaded(this.pokemons);

  @override
  List<Object?> get props => [pokemons];
}


class FilterError extends FilterState {
  final String message;

  FilterError(this.message);

  @override
  List<Object?> get props => [message];
}
