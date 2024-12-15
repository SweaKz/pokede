import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokede/filter/bloc/filter_bloc.dart';
import 'package:pokede/filter/bloc/filter_event.dart';
import 'package:pokede/filter/bloc/filter_state.dart';

class FilterSelectionPage extends StatelessWidget {
  const FilterSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilterBloc()..add(LoadDefaultFilters()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sélection des régions'),
        ),
        body: BlocBuilder<FilterBloc, FilterState>(
  builder: (context, state) {
    if (state is FiltersLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (state is FiltersLoaded) {
      if (state.filters.isEmpty) {
        return Center(child: Text("Aucun filtre disponible."));
      }
      return ListView.builder(
        itemCount: state.filters.length,
        itemBuilder: (context, index) {
          final filter = state.filters[index];
          return GestureDetector(
            onTap: () {
              context.read<FilterBloc>().add(ApplyFilter(filter));
              Navigator.pushNamed(context, '/pokemon_list');
            },
            child: Card(
              margin: EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(filter.backgroundImage),
                    fit: BoxFit.cover,
                  ),
                ),
                height: 100,
                child: Center(
                  child: Text(
                    filter.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    } else if (state is FilterError) {
      return Center(child: Text("Erreur : ${state.message}"));
    } else {
      return Center(child: Text("État inconnu."));
    }
  },
)
      ),
    );
  }
}
