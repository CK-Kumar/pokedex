import 'package:get/get.dart';

class Pokemon {
  final String name;

  final String pokemonUrl;

  String imageUrl;

  String highResolutionUrl;

  int id;

  int height;

  int weight;

  List<String> types;

  // Observables for runtime use
  late RxString imageUrlRx;
  late RxString highResolutionUrlRx;
  late RxInt idRx;
  late RxInt heightRx;
  late RxInt weightRx;
  late RxList<String> typesRx;

  Pokemon(
    this.name,
    this.pokemonUrl, {
    this.imageUrl = '',
    this.highResolutionUrl = '',
    this.id = 0,
    this.height = 0,
    this.weight = 0,
    this.types = const [],
  }) {
    // Initialize observables
    imageUrlRx = imageUrl.obs;
    highResolutionUrlRx = highResolutionUrl.obs;
    idRx = id.obs;
    heightRx = height.obs;
    weightRx = weight.obs;
    typesRx = types.obs;
  }

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(json['name'] ?? '', json['url'] ?? '');
  }

  static List<Pokemon> listFromJson(List? list) {
    return list?.map((json) => Pokemon.fromJson(json)).toList() ?? [];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': pokemonUrl,
      'sprites': {
        'front_default': imageUrl,
        'other': {
          'official-artwork': {'front_default': highResolutionUrl}
        }
      },
      'id': id,
      'height': height,
      'weight': weight,
      'types': types
          .map((type) => {
                'type': {'name': type}
              })
          .toList(),
    };
  }

  void updateFromDetailJson(Map<String, dynamic> json) {
    imageUrl = json['sprites']['front_default'];
    highResolutionUrl = json['sprites']['other']['official-artwork']
            ['front_default'] ??
        imageUrl;
    id = json['id'];
    height = json['height'];
    weight = json['weight'];
    types = (json['types'] as List)
        .map((type) => type['type']['name'].toString())
        .toList();
    // Update observables
    imageUrlRx.value = imageUrl;
    highResolutionUrlRx.value = highResolutionUrl;
    idRx.value = id;
    heightRx.value = height;
    weightRx.value = weight;
    typesRx.value = types;
  }
}
