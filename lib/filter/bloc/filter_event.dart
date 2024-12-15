import 'package:equatable/equatable.dart';

import '../model/filter_model.dart';

abstract class FilterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadDefaultFilters extends FilterEvent {}

class AddCustomFilter extends FilterEvent {
  final FilterModel filter;

  AddCustomFilter(this.filter);

  @override
  List<Object?> get props => [filter];
}

class ApplyFilter extends FilterEvent {
  final FilterModel filter;

  ApplyFilter(this.filter);

  @override
  List<Object?> get props => [filter];
}