import 'package:pokedex_poyectfinal/Entitys/Pokemon.dart';

class PokemonPage {

  String next;
  final String? previous;
  final List<String> urlPokemones;
  List<Pokemon>? pokemones;

  PokemonPage({
    required this.next,
    this.previous,
    required this.urlPokemones,
    this.pokemones
  });

  factory PokemonPage.fromJson(Map<String, dynamic> json) {
    List<dynamic> results = json['results'];
    List<String> urlPokemones = results.map((result) => result['url'].toString()).toList();

    return PokemonPage(

        next: json['next'],
        previous: json['previous'],
        urlPokemones: urlPokemones
    );
  }

  void setPokemones(List<Pokemon> valor) {
    pokemones = valor; // Asignar un valor a la propiedad.
  }

}