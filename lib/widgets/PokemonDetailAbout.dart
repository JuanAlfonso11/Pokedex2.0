import 'package:flutter/material.dart';
import 'package:pokedex_poyectfinal/Entitys/Pokemon.dart';

class PokemonDetailAbout extends StatelessWidget {
  final Pokemon? pokemon;
  final Color? color;

  const PokemonDetailAbout({Key? key, required this.pokemon, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final baseStats = pokemon?.baseStats;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        _buildStatRow('Altura', '${(pokemon?.height ?? 0) / 10} m'),
        const SizedBox(height: 16),
        _buildStatRow('Peso', '${(pokemon?.weight ?? 0) / 10} kg'),
        const SizedBox(height: 16),
        if (baseStats != null) ...[
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          _buildStatsSection('Estadísticas', [
            _buildStatBar('HP', baseStats.hp, 255),
            _buildStatBar('Ataque', baseStats.attack, 255),
            _buildStatBar('Defensa', baseStats.defence, 255),
            _buildStatBar('Ataque Especial', baseStats.specialAttack, 255),
            _buildStatBar('Defensa Especial', baseStats.specialDefence, 255),
            _buildStatBar('Velocidad', baseStats.speed, 255),
          ]),
        ],
      ],
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            '$label:',
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: color ?? Colors.blue,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsSection(String sectionTitle, List<Widget> stats) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          sectionTitle,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        ...stats,
      ],
    );
  }

  Widget _buildStatBar(String label, int value, int maxValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label:',
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: LinearProgressIndicator(
            value: value / maxValue,
            backgroundColor: Colors.grey,
            valueColor: AlwaysStoppedAnimation<Color>(color ?? Colors.blue),
            minHeight: 10.0,
          ),
        ),
      ],
    );
  }
}