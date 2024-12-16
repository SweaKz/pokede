import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/filter_bloc.dart';
import '../bloc/filter_event.dart';
import '../bloc/filter_state.dart';

class FilterSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilterBloc()..add(LoadDefaultFilters()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Sélection des régions'),
        ),
        body: BlocBuilder<FilterBloc, FilterState>(
          builder: (context, state) {
            if (state is FiltersLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is FiltersLoaded) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.filters.length,
                      itemBuilder: (context, index) {
                        final filter = state.filters[index];
                        return GestureDetector(
                          onTap: () {
                            // Naviguer vers la deuxième page avec le filtre sélectionné
                            Navigator.pushNamed(
                              context,
                              '/pokemon_list',
                              arguments: filter,
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(filter.backgroundImage!),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black.withOpacity(0.5),
                            ),
                            height: 100,
                            child: Center(
                              child: Text(
                                filter.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/custom_filter');
                        },
                        child: Icon(Icons.add),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: Text('Erreur lors du chargement des filtres.'));
            }
          },
        ),
      ),
    );
  }
}
