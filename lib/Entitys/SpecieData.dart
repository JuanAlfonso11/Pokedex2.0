
class SpecieData {

  final int catchRate;
  final int baseFriendship;
  final String growthRate;
  final String color;
  final List<String> eggGroups;
  final int gender;
  final int eggCycles;
  final String evolucionUrl;

  SpecieData({
    required this.catchRate,
    required this.baseFriendship,
    required this.growthRate,
    required this.color,
    required this.eggGroups,
    required this.gender,
    required this.eggCycles,
    required this.evolucionUrl
  });


  factory SpecieData.fromJson(Map<String, dynamic> json) {
    return SpecieData(
        catchRate: json['capture_rate'],
        baseFriendship: json['base_happiness'],
        growthRate: json['growth_rate']['name'],
        color: json['color']['name'],
        gender: json['gender_rate'],
        eggCycles: json['hatch_counter'],
        evolucionUrl: json['evolution_chain']['url'],
        eggGroups: (json['egg_groups'] as List)
            .map((typeEntry) => typeEntry['name'].toString())
            .toList()
    );
  }

}
