import 'package:flutter/material.dart';
import 'package:pokedex_poyectfinal/Entitys/Hability.dart';

class PokemonDetailHability extends StatelessWidget {
  final List<Hability> pokemonHabilities;
  final List<String> movimientos;
  final Color? color;

  const PokemonDetailHability({
    Key? key,
    required this.pokemonHabilities,
    required this.movimientos,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _buildHabilitiesList(),
        _buildMovimientosGrid(),
      ],
    );
  }

  Widget _buildMovimientosGrid() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Movimientos:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: color ?? Colors.black,
              ),
            ),
            const SizedBox(height: 8.0),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: movimientos.length,
              itemBuilder: (context, index) {
                final movimiento = movimientos[index];
                return Card(
                  color: Colors.grey[200],
                  // Ajusta el padding general del Card
                  margin: const EdgeInsets.all(4.0),
                  // Ajusta el padding interno del contenido del Card
                  child: Container(
                    // padding: const EdgeInsets.all(1.0),
                    height: 20.0,
                    child: Center(
                      child: Text(
                        capitalize(movimiento),
                        style: const TextStyle(fontSize: 14.0),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHabilitiesList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: pokemonHabilities.length,
      itemBuilder: (context, index) {
        final hability = pokemonHabilities[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  capitalize(hability.name),
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: color ?? Colors.black,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  hability.description,
                  style: const TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String capitalize(String text) {
    return text.isNotEmpty ? text[0].toUpperCase() + text.substring(1) : text;
  }
}
