import 'package:flutter/material.dart';
import 'package:pokedex_poyectfinal/Entitys/Pokemon.dart';
import 'package:pokedex_poyectfinal/services/PokemonService.dart';
import 'package:pokedex_poyectfinal/widgets/ListItemPokemon.dart';

class SearchPokemonDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Verifica si el query está vacío
    if (query.trim().isEmpty) {
      return const Text('Búsqueda vacía');
    }

    if (esNumero(query)) {
      // Si el query es un número, asume que es un ID
      return FutureBuilder(
        future: getPokemonByNameOrId(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            );
          } else if (snapshot.hasError) {
            return const Text('Error al cargar el Pokémon');
          } else if (snapshot.hasData) {
            final Pokemon result = snapshot.data as Pokemon;
            return ListItemPokemon(pokemon: result);
          } else {
            return const Text('No se encontraron resultados');
          }
        },
      );
    } else {
      // Si el query no es un número, busca por nombre
      return FutureBuilder(
        future: getAllPokemonNames(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(strokeWidth: 4),
            );
          } else if (snapshot.hasError) {
            return const Text('Error en la búsqueda');
          } else if (!snapshot.hasData || (snapshot.data as List<String>).isEmpty) {
            return const Text('No se encontraron resultados');
          } else {
            final allPokemonNames = snapshot.data as List<String>;
            final filteredNames = allPokemonNames.where((name) {
              return name.toLowerCase().contains(query.toLowerCase());
            }).toList();

            return ListView.builder(
              itemCount: filteredNames.length,
              itemBuilder: (context, index) {
                final pokemonName = filteredNames[index];
                return FutureBuilder(
                  future: getPokemonByNameOrId(pokemonName),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(strokeWidth: 2);
                    } else if (snapshot.hasError) {
                      return const Text('Error al cargar el Pokémon');
                    } else if (snapshot.hasData) {
                      final Pokemon result = snapshot.data as Pokemon;
                      return ListItemPokemon(pokemon: result);
                    } else {
                      return const Text('No se encontraron resultados');
                    }
                  },
                );
              },
            );
          }
        },
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Esto se puede personalizar si deseas mostrar sugerencias de búsqueda.
    return const Text('Sugerencias de búsqueda aquí');
  }

  bool esNumero(String str) {
    final pattern = r'^[0-9]+$';
    final regExp = RegExp(pattern);
    return regExp.hasMatch(str);
  }
}
