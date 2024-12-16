import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/filter_model.dart';
import 'filter_event.dart';
import 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(FiltersLoading()) {
    on<LoadDefaultFilters>(_onLoadDefaultFilters);
    on<AddCustomFilter>(_onAddCustomFilter);
  }

  void _onLoadDefaultFilters(
      LoadDefaultFilters event, Emitter<FilterState> emit) {
    final defaultFilters = [
      FilterModel(name: "Kanto (1G)", backgroundImage: "assets/region/region-kanto.png", generations: [1]),
      FilterModel(name: "Johto (2G)", backgroundImage: "assets/region/region-johto.png", generations: [2]),
      FilterModel(name: "Hoenn (3G)", backgroundImage: "assets/region/region-hoenn.png", generations: [3]),
      FilterModel(name: "Sinnoh (4G) / Hisui", backgroundImage: "assets/region/region-sinnoh.png", generations: [4]),
      FilterModel(name: "Unys (5G)", backgroundImage: "assets/region/region-unys.png", generations: [5]),
    ];

    emit(FiltersLoaded(defaultFilters));
  }

  void _onAddCustomFilter(AddCustomFilter event, Emitter<FilterState> emit) {
    if (state is FiltersLoaded) {
      final updatedFilters = List<FilterModel>.from((state as FiltersLoaded).filters)
        ..add(event.filter);
      emit(FiltersLoaded(updatedFilters));
    }
  }
}
