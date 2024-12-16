import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/filter_bloc.dart';
import '../bloc/filter_event.dart';
import '../bloc/filter_state.dart';

class FilterSelectionPage extends StatelessWidget {
  const FilterSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilterBloc()..add(LoadDefaultFilters()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sélection des filtres'),
        ),
        body: BlocBuilder<FilterBloc, FilterState>(
          builder: (context, state) {
            if (state is FiltersLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FiltersLoaded) {
              return ListView.builder(
                itemCount: state.filters.length,
                itemBuilder: (context, index) {
                  final filter = state.filters[index];
                  return GestureDetector(
                    onTap: () {
                      // Plus tard, naviguer vers la liste de Pokémon filtrée
                      Navigator.pushNamed(
                        context,
                        '/pokemon_list',
                        arguments: filter,
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      height: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black.withOpacity(0.5),
                        image: (filter.backgroundImage != null)
                            ? DecorationImage(
                                image: AssetImage(filter.backgroundImage!),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: Text(
                        filter.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text('Erreur lors du chargement des filtres.'),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/custom_filter');
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
