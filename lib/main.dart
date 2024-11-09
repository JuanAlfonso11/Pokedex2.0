import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pokedex_poyectfinal/Entitys/PokemonPage.dart';
import 'package:pokedex_poyectfinal/pages/PokemonList.dart';
import 'package:pokedex_poyectfinal/search_pokemon_delegate.dart';
import 'package:pokedex_poyectfinal/services/PokemonProvider.dart';
import 'package:pokedex_poyectfinal/services/PokemonService.dart';
import 'package:pokedex_poyectfinal/widgets/MenuLateral.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MaterialApp(
    home: MainApp(),
  ));
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late Future<PokemonPage> pokemonPage;
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    loadPokemonData();
  }

  void loadPokemonData() async {
    // Simula la carga del fondo de pantalla
    await Future.delayed(const Duration(seconds: 2));

    // Muestra la pantalla de carga mientras se carga el fondo
    setState(() {});

    // Simula la carga de datos
    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      isLoading = false;
      // Inicializa pokemonPage con getPokemonsPage(null)
      pokemonPage = getPokemonsPage(null);
    });
  }

  @override
  Widget build(BuildContext context) {
    const title = "Pokedex";

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TypeSelected()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          primaryColor: Colors.redAccent.shade700,
        ),
        title: title,
        home: isLoading
            ? LoadingScreen()
            : Scaffold(
          drawer: MenuLateral(),
          appBar: AppBar(
            title: Image.asset(
              'assets/pokedex.png',
              width: 150,
              height: 150,
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.search_rounded),
                tooltip: 'Search a pokemon',
                onPressed: () {
                  showSearch(context: context, delegate: SearchPokemonDelegate());
                },
              )
            ],
          ),
          body: FutureBuilder(
            future: pokemonPage,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LoadingScreen(); // Muestra la pantalla de carga
              } else if (snapshot.hasError) {
                return Text('Error loading data: ${snapshot.error}');
              } else {
                return PokemonList(pokemonPage: snapshot.data);
              }
            },
          ),

        ),
      ),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red, // Fondo rojo
      body: Center(
        child: Image.asset(
          'assets/loading/loading-pokeball.gif',
          width: 300,
          height: 300,
        ),
      ),
    );
  }
}
