class Pokemon {
  final String name;
  final String pokemonUrl;
  Pokemon(this.name, this.pokemonUrl);

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(json['name'] ?? '', json['url'] ?? '');
  }

  static List<Pokemon> listFromJson(List? list) {
    List<Pokemon> pokemons = [];
    if (list == null) {
      return pokemons;
    }
    for (var post in list) {
      pokemons.add(Pokemon.fromJson(post));
    }
    return pokemons;
  }
}
