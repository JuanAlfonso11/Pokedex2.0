class EvolutionDetails {
  int? minLevel; // Cambiado a int? para admitir valores nulos
  String triggerName;
  String triggerUrl;

  EvolutionDetails({
    required this.minLevel,
    required this.triggerName,
    required this.triggerUrl,
  });

  factory EvolutionDetails.fromJson(Map<String, dynamic> json) {
    return EvolutionDetails(
      minLevel: json['min_level'] as int?, // Asignar int? para permitir valores nulos
      triggerName: json['trigger']['name'],
      triggerUrl: json['trigger']['url'],
    );
  }
}

class EvolutionChainNode {
  bool isBaby;
  String speciesName;
  String speciesUrl;
  List<EvolutionDetails> evolutionDetails;
  List<EvolutionChainNode> evolvesTo;

  EvolutionChainNode({
    required this.isBaby,
    required this.speciesName,
    required this.speciesUrl,
    required this.evolutionDetails,
    required this.evolvesTo,
  });

  factory EvolutionChainNode.fromJson(Map<String, dynamic> json) {
    return EvolutionChainNode(
      isBaby: json['is_baby'],
      speciesName: json['species']['name'],
      speciesUrl: json['species']['url'],
      evolutionDetails: (json['evolution_details'] as List<dynamic>?)
          ?.map((detail) => EvolutionDetails.fromJson(detail))
          .toList() ?? [], // Si es nulo, asigna una lista vacía
      evolvesTo: (json['evolves_to'] as List<dynamic>?)
          ?.map((node) => EvolutionChainNode.fromJson(node))
          .toList() ?? [], // Si es nulo, asigna una lista vacía
    );
  }
}

class EvolutionChain {
  EvolutionChainNode chain;

  EvolutionChain({required this.chain});

  factory EvolutionChain.fromJson(Map<String, dynamic> json) {
    return EvolutionChain(chain: EvolutionChainNode.fromJson(json['chain']));
  }
}
