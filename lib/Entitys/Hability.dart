
class Hability {

  final String name;
  final String description;

  Hability ({
    required this.name,
    required this.description
  });

  Hability.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        description = _getDescriptionForLanguage(json['effect_entries'], 'en');

  static String _getDescriptionForLanguage(List<dynamic> effectEntries, String targetLanguage) {
    for (var entry in effectEntries) {
      if (entry['language']['name'] == targetLanguage) {
        return entry['effect'];
      }
    }
    return ''; // O devuelve un valor predeterminado o lanza una excepción según tus necesidades.
  }

}