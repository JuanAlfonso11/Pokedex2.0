class BaseStats {
  final int hp;
  final int attack;
  final int defence;
  final int specialAttack;
  final int specialDefence;
  final int speed;

  BaseStats({
    required this.hp,
    required this.attack,
    required this.defence,
    required this.specialAttack,
    required this.specialDefence,
    required this.speed,
  });


  factory BaseStats.fromJson(List<dynamic> stats) {
    int hp = 0;
    int attack = 0;
    int defence = 0;
    int specialAttack = 0;
    int specialDefence = 0;
    int speed = 0;

    for (var stat in stats) {
      final String statName = stat['stat']['name'];

      switch (statName) {
        case 'hp':
          hp = stat['base_stat'];
          break;
        case 'attack':
          attack = stat['base_stat'];
          break;
        case 'defense':
          defence = stat['base_stat'];
          break;
        case 'special-attack':
          specialAttack = stat['base_stat'];
          break;
        case 'special-defense':
          specialDefence = stat['base_stat'];
          break;
        case 'speed':
          speed = stat['base_stat'];
          break;
        default:
        // Puedes manejar otros casos si es necesario
          break;
      }
    }

    return BaseStats(
      hp: hp,
      attack: attack,
      defence: defence,
      specialAttack: specialAttack,
      specialDefence: specialDefence,
      speed: speed,
    );
  }

}