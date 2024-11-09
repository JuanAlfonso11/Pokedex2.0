import 'package:flutter/material.dart';
import 'package:pokedex_poyectfinal/Entitys/Evoluciones.dart';
import 'package:pokedex_poyectfinal/Entitys/Hability.dart';
import 'package:pokedex_poyectfinal/Entitys/Pokemon.dart';
import 'package:pokedex_poyectfinal/widgets/PokemonDetailAbout.dart';
import 'package:pokedex_poyectfinal/widgets/PokemonDetailEvolutions.dart';
import 'package:pokedex_poyectfinal/widgets/PokemonDetailHability.dart';

import '../services/FavoritePokemonService.dart';

class PokemonDetail extends StatefulWidget {
  final Pokemon? pokemon;
  final Color? backgroundColor;
  final bool isFavorite;
  final List<Hability> pokemonSkills;
  final EvolutionChain pokemonEvolution;

  PokemonDetail({
    Key? key,
    required this.pokemon,
    this.backgroundColor,
    this.isFavorite = false,
    required this.pokemonSkills,
    required this.pokemonEvolution,
  }) : super(key: key);

  @override
  _PokemonDetailState createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {
  final TextStyle _textStyle = const TextStyle(
    fontFamily: 'Google Sans',
    fontSize: 22.0,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    final textColor = widget.backgroundColor == Colors.white || widget.backgroundColor == Colors.yellow
        ? Colors.black
        : Colors.white;
    final tabLabelColor = widget.backgroundColor == Colors.white ? Colors.black : widget.backgroundColor; // Color del AppBar

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(300.0),
          child: AppBar(
            backgroundColor: widget.backgroundColor,
            elevation: 0,
            flexibleSpace: Stack(
              alignment: Alignment.center,
              children: [
                Opacity(
                  opacity: 0.7,
                  child: Image.asset(
                    widget.backgroundColor == Colors.white || widget.backgroundColor == Colors.yellow
                        ? 'assets/pokeballblack.png'
                        : 'assets/pokeball.png',
                    height: 300,
                    width: 550,
                    fit: BoxFit.cover,
                  ),
                ),
                Image.network(
                  widget.pokemon?.image ?? '',
                  height: 220,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 140,
                  left: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '#${widget.pokemon?.id}',
                          style: _textStyle.copyWith(
                            color: textColor,
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          capitalize(widget.pokemon?.name ?? ''),
                          style: _textStyle.copyWith(
                            color: textColor,
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Card(
                            color: const Color.fromARGB(70, 255, 255, 255),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Wrap(
                                spacing: 8.0,
                                runSpacing: 8.0,
                                children: [
                                  for (var tipo in widget.pokemon?.types ?? [])
                                    Image.asset(
                                      'assets/icon_types/$tipo.png',
                                      width: 40.0,
                                      height: 40.0,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 15,
                  right: 15,
                  child: _buildFavoriteButton(),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: widget.backgroundColor,
        body: Center(
          child: Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                TabBar(
                  tabs: const [
                    Tab(
                      child: Text(
                        "Sobre",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Evolucion",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Habilidades",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                  indicatorColor: tabLabelColor,
                  labelColor: tabLabelColor,
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      PokemonDetailAbout(pokemon: widget.pokemon, color: widget.backgroundColor),
                      PokemonDetailEvolutions(pokemonEvolution: widget.pokemonEvolution),
                      PokemonDetailHability(pokemonHabilities: widget.pokemonSkills, movimientos: widget.pokemon!.moves, color: widget.backgroundColor)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFavoriteButton() {
    return GestureDetector(
      onTap: () async {
        FavoritePokemonService favService = FavoritePokemonService();
        await favService.addToFavorites(widget.pokemon!.name);
        // print(await favService.getFavoritePokemonList);
        setState(() {
          widget.pokemon!.isFavorite = !widget.pokemon!.isFavorite;
        });
      },
      child: Icon(
        widget.pokemon!.isFavorite ? Icons.star : Icons.star_border,
        color: widget.pokemon!.isFavorite || widget.backgroundColor == Colors.yellow
            ? Colors.orange
            : Colors.orange,
        size: 49.0,
      ),
    );
  }

  String capitalize(String text) {
    return text.isNotEmpty ? text[0].toUpperCase() + text.substring(1) : text;
  }
}



