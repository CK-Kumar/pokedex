import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:pokedex/data/api_service.dart';
import 'package:pokedex/models/pokemon_model.dart';

class PokedexService extends GetxService {
  final Api _api = Get.find();
  RxList<Pokemon> pokemons = <Pokemon>[].obs;

  Future init() async {
    log('Pokemon getting loaded...');
    await getPokemons();
  }

  getPokemons() async {
    try {
      var response = await _api.getPokemons('151');
      var jsonDecode = json.decode(response);
      List? jsonList = jsonDecode['results'];
      pokemons.value = Pokemon.listFromJson(jsonList);
    } catch (ex) {
      log('Error while fetching pokemons: $ex');
    }
  }
}
