import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'filter/ui/filter_selection_page.dart';
import 'pokemon/repository/pokemon_repository.dart';
import 'pokemon/ui/pokemon_list_page.dart'; // adapter selon ton arborescence


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = super.createHttpClient(context);
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return client;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final pokemonRepository = PokemonRepository(); // Une seule instance du repo, par exemple

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokédex',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const FilterSelectionPage(),
        '/custom_filter': (context) => const Scaffold(
              body: Center(child: Text('Custom Filter Page')),
            ),
        '/pokemon_list': (context) => PokemonListPage(repository: pokemonRepository),
      },
    );
  }
}
