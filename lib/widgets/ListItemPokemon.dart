import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_poyectfinal/Entitys/Evoluciones.dart';
import 'package:pokedex_poyectfinal/Entitys/Hability.dart';
import 'package:pokedex_poyectfinal/Entitys/Pokemon.dart';
import 'package:pokedex_poyectfinal/pages/PokemonDetail.dart';
import 'package:pokedex_poyectfinal/services/FavoritePokemonService.dart';
import 'package:pokedex_poyectfinal/services/PokemonService.dart';

class ListItemPokemon extends StatefulWidget {
  final Pokemon? pokemon;

  const ListItemPokemon({super.key, required this.pokemon});

  @override
  State<ListItemPokemon> createState() => _ListItemPokemonState();
}

class _ListItemPokemonState extends State<ListItemPokemon> {
  Color? color;
  bool colorLoaded = false;
  bool isFavorite = false;

  final TextStyle _textStyle = const TextStyle(
    fontFamily: 'Google Sans',
    fontSize: 15.0,
    fontWeight: FontWeight.bold,
  );

  @override
  void initState() {
    super.initState();
    fetchColorForPokemon();
  }

  Color getColorForColorName(String colorName) {
    if (kDebugMode) {
      print("Asignando color");
    }
    Map<String, Color> colorMap = {
      'red': Colors.red,
      'blue': Colors.blue,
      'green': Colors.green,
      'yellow': Colors.yellow,
      'brown': Colors.brown,
      'purple': Colors.purple,
      'gray': Colors.grey,
      'white': Colors.white,
      'pink': Colors.pink,
      'black': Colors.black
    };

    return colorMap[colorName] ?? Colors.green.shade600;
  }

  Future<void> fetchColorForPokemon() async {
    final List<String> colors = [
      'red',
      'blue',
      'green',
      'yellow',
      'brown',
      'purple',
      'gray',
      'white',
      'pink',
      'black'
    ];

    for (var colorName in colors) {
      final species = await getPokemonSpeciesByColor(colorName);

      if (species.contains(widget.pokemon?.species.toLowerCase())) {
        if (mounted) {
          setState(() {
            color = getColorForColorName(colorName);
            colorLoaded = true;
          });
        }
        break;
      }
    }
  }

  Color getTextColor() {
    if (color == Colors.white || color == Colors.yellow) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  String capitalize(String text) {
    return text.isNotEmpty ? text[0].toUpperCase() + text.substring(1) : text;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        List<Hability> habilidades = [];
        for (var i = 0; i < widget.pokemon!.habilities.length; i++) {
          habilidades.add(await getPokemonHabilityByName(widget.pokemon!.habilities[i]));
        }

        EvolutionChain ec = await getPokemonEvolutions(widget.pokemon!.specieData!.evolucionUrl);

        print(ec.chain.speciesName);

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PokemonDetail(
                pokemon: widget.pokemon,
                backgroundColor: getColorForColorName(widget.pokemon!.specieData!.color),
                pokemonSkills: habilidades,
                pokemonEvolution: ec
            ),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(17.0),
        ),
        margin: const EdgeInsets.all(8.0),
        color: colorLoaded ? color : Colors.transparent,
        child: SizedBox(
          height: 145.0,
          child: Stack(
            children: [
              Positioned(
                  right: 36,
                  top: 5,
                  child: Opacity(
                    opacity: 0.8,
                    child:  Image.asset(
                      color == Colors.white || color == Colors.yellow
                          ? 'assets/pokeballblack.png'
                          : 'assets/pokeball.png',
                      height: 135,
                      width: 135,
                      fit: BoxFit.cover,
                    ),
                  )
              ),
              Positioned(
                right: 40,
                top: 10,
                child: Image.network(
                  widget.pokemon?.image ?? "",
                  width: 125,
                  height: 125,
                  fit: BoxFit.cover,
                ),
              ),
              ListTile(
                title: Text(
                  capitalize(widget.pokemon?.name ?? ''),
                  style: TextStyle(
                    fontSize: 28.0,
                    color: getTextColor(),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "#${widget.pokemon?.id}",
                      style: TextStyle(
                        color: getTextColor(),
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: widget.pokemon?.types.map((tipo) => Image.asset(
                          'assets/icon_types/$tipo.png',
                          width: 30.0,
                          height: 30.0,
                        )).toList() ?? [],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 7,
                right: 7,
                child: GestureDetector(
                  onTap: () {

                    FavoritePokemonService favService = FavoritePokemonService();

                    favService.addToFavorites(widget.pokemon!.name);

                    setState(() {
                      widget.pokemon!.isFavorite = !widget.pokemon!.isFavorite;
                    });
                    // pon la lógica de la base de datos aqui :)
                    // la variable "isFavorite" es para saber si algun pokemon es favorito
                  },
                  child: Icon(
                    widget.pokemon!.isFavorite ? Icons.star : Icons.star_border,
                    color: widget.pokemon!.isFavorite || color == Colors.yellow ? Colors.orange : Colors.orange,
                    size: 39.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
