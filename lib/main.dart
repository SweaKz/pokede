import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../filter/bloc/filter_bloc.dart';
import '../../filter/ui/filter_selection_page.dart';
import '../../filter/ui/custom_filter_page.dart';
import '../../pokemon/ui/pokemon_list_page.dart';
import 'filter/bloc/filter_event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilterBloc()..add(LoadDefaultFilters()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pokédex',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/',
        routes: {
          '/': (context) => FilterSelectionPage(),
          '/custom_filter': (context) => CustomFilterPage(),
          '/pokemon_list': (context) => PokemonListPage(),
        },
      ),
    );
  }
}

