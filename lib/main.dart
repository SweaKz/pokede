import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'filter/bloc/filter_bloc.dart';
import 'filter/bloc/filter_event.dart';
import 'filter/ui/filter_selection_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokédex',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => BlocProvider(
              create: (context) => FilterBloc()..add(LoadDefaultFilters()),
              child: FilterSelectionPage(),
            ),
        '/custom_filter': (context) => Scaffold(
              // Page intermédiaire pour créer un filtre personnalisé (à implémenter plus tard)
              body: Center(child: Text('Custom Filter Page')),
            ),
        '/pokemon_list': (context) => Scaffold(
              // Page d'affichage des Pokémon filtrés (à implémenter plus tard)
              body: Center(child: Text('Pokémon List Page')),
            ),
      },
    );
  }
}
