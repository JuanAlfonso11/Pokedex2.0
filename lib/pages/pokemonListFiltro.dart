import 'package:flutter/material.dart';
import 'package:pokedex_poyectfinal/Entitys/Pokemon.dart';
import 'package:pokedex_poyectfinal/search_pokemon_delegate.dart';
import 'package:pokedex_poyectfinal/services/PokemonService.dart';
import 'package:pokedex_poyectfinal/widgets/ListItemPokemon.dart';
import 'package:pokedex_poyectfinal/widgets/MenuLateral.dart';

class PokemonListFiltro extends StatefulWidget {
  final List<String> pokemonNames;

  const PokemonListFiltro({Key? key, required this.pokemonNames}) : super(key: key);

  @override
  State<PokemonListFiltro> createState() => _PokemonListFiltroState();
}

class _PokemonListFiltroState extends State<PokemonListFiltro> {
  late List<Future<Pokemon>> pokemonFutures;

  @override
  void initState() {
    super.initState();
    pokemonFutures = widget.pokemonNames.map((pokemonName) {
      return getPokemonByNameOrId(pokemonName);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold
      (
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
      body: ListView.builder(
        itemCount: pokemonFutures.length,
        itemBuilder: (context, index) {
          return FutureBuilder<Pokemon>(
            future: pokemonFutures[index],
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(strokeWidth: 2);
              } else if (snapshot.hasError) {
                return const Text('Error al cargar el Pokémon');
              } else if (snapshot.hasData && snapshot.data?.id != -1) {
                final Pokemon result = snapshot.data as Pokemon;
                // return(Text(result.name));
                return ListItemPokemon(pokemon: result);
              } else {
                return const Text('No se encontraron resultados');
              }
            },
          );
        },
      ),
    );
  }
}
