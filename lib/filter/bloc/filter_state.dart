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

class FilterError extends FilterState {
  final String message;

  FilterError(this.message);

  @override
  List<Object?> get props => [message];
}
