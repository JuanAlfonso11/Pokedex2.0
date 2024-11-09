import 'package:pokedex_poyectfinal/Entitys/BaseStats.dart';
import 'package:pokedex_poyectfinal/Entitys/SpecieData.dart';

class Pokemon {
  final int id;
  final String name;
  final String image;
  String? description;
  final int height;
  final int weight;
  final String species;
  final List<String> types;
  SpecieData? specieData;
  BaseStats? baseStats;
  final int baseExp;
  List<String> habilities;
  List<String> moves;
  bool isFavorite;

  Pokemon({
    required this.id,
    required this.name,
    required this.image,
    this.description,
    required this.height,
    required this.weight,
    required this.species,
    required this.types,
    required this.baseExp,
    this.specieData,
    this.baseStats,
    required this.habilities,
    required this.moves,
    required this.isFavorite
  });


  Pokemon.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        image = json['sprites']['other']['official-artwork']['front_default'],
        height = json['height'],
        weight = json['weight'],
        species = json['species']['name'],
        baseStats = BaseStats.fromJson(json['stats']),
        baseExp = json['base_experience'],
        isFavorite = false,
        habilities = (json['abilities'] as List)
            .map((abilityEntry) => abilityEntry['ability']['name'].toString()).toList(),
        moves = (json['moves'] as List)
            .map((moveEntry) => moveEntry['move']['name'].toString())
            .toList(),
        types = (json['types'] as List)
            .map((typeEntry) => typeEntry['type']['name'].toString())
            .toList();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'isFavorite': isFavorite
    };
  }
}