import 'package:flutter/material.dart';
import 'package:pokedex_poyectfinal/Entitys/Evoluciones.dart';
import 'package:pokedex_poyectfinal/Entitys/Pokemon.dart';
import 'package:pokedex_poyectfinal/services/PokemonService.dart';
import 'package:pokedex_poyectfinal/widgets/ListItemPokemon.dart';

class PokemonDetailEvolutions extends StatefulWidget {
  final EvolutionChain pokemonEvolution;

  const PokemonDetailEvolutions({Key? key, required this.pokemonEvolution}) : super(key: key);

  @override
  State<PokemonDetailEvolutions> createState() => _PokemonDetailEvolutionsState();
}

class _PokemonDetailEvolutionsState extends State<PokemonDetailEvolutions> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            _buildEvolutionChain(widget.pokemonEvolution.chain),
          ],
        ),
      ),
    );
  }

  Widget _buildEvolutionChain(EvolutionChainNode chainNode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildNode(chainNode),
        const SizedBox(height: 16),
        if (chainNode.evolvesTo.isNotEmpty)
          for (var evolvesToNode in chainNode.evolvesTo) _buildEvolutionChain(evolvesToNode),
      ],
    );
  }

  Widget _buildNode(EvolutionChainNode node) {
    return FutureBuilder<Pokemon>(
      future: getPokemonByNameOrId(node.speciesName),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Si aún está cargando, puedes mostrar un indicador de carga
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Si hay un error, puedes manejarlo aquí
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          // Si la operación asíncrona fue exitosa, actualiza el estado
          var evolucion = snapshot.data;

          return ListItemPokemon(pokemon: evolucion);

          // return Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Text(
          //       'Species: ${node.speciesName}',
          //       style: const TextStyle(
          //         fontSize: 16.0,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //     Text('Is Baby: ${node.isBaby}'),
          //     Image.network(evolucion!.image, width: 120.0),
          //   ],
          // );
        } else {
          // Si no hay datos disponibles, puedes manejarlo aquí
          return Text('No se encontraron datos');
        }
      },
    );
  }
}
