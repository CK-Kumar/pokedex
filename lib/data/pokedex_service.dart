import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import 'package:pokedex/data/api_service.dart';
import 'package:pokedex/models/pokemon_model.dart';
import 'package:pokedex/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PokedexService extends GetxService {
  final Api _api = Get.find();
  RxList<Pokemon> pokemons = <Pokemon>[].obs;

  Future init() async {
    log('Pokemon getting loaded...');
    await getPokemons();
  }

  getPokemons() async {
    try {
      var response = await _api.getPokemons(Data.pokemonLimit);
      var jsonDecode = json.decode(response);
      List? jsonList = jsonDecode[Data.results];
      pokemons.value = Pokemon.listFromJson(jsonList);
      await updatePokemonDetails();
    } catch (ex) {
      log('Error while fetching pokemons: $ex');
    }
  }

  updatePokemonDetails() async {
    for (var pokemon in pokemons) {
      try {
        var response = await _api.getPokemonDetails(pokemon.pokemonUrl);
        var jsonDecode = json.decode(response);
        pokemon.updateFromDetailJson(jsonDecode);
      } catch (ex) {
        log('Error while fetching pokemon details: $ex');
      }
    }
  }

  final String caughtPokemonsKey = 'caughtPokemons';

//To save the captured pokemon in local
  Future<void> savePokemon(Pokemon pokemon) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> caughtPokemons = prefs.getStringList(caughtPokemonsKey) ?? [];
    if (!caughtPokemons.contains(pokemon.id.toString())) {
      caughtPokemons.add(jsonEncode(pokemon.toJson()));
      await prefs.setStringList(caughtPokemonsKey, caughtPokemons);
    }
  }

//To remove the captured pokemon from the local
  Future<void> removePokemon(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> caughtPokemons = prefs.getStringList(caughtPokemonsKey) ?? [];
    caughtPokemons.removeWhere((pokemon) {
      var decodedPokemon = jsonDecode(pokemon);
      return decodedPokemon['id'] == id;
    });
    await prefs.setStringList(caughtPokemonsKey, caughtPokemons);
  }

//To check if the pokemon is already caught
  Future<bool> isPokemonCaught(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> caughtPokemons = prefs.getStringList(caughtPokemonsKey) ?? [];
    return caughtPokemons.any((pokemon) {
      var decodedPokemon = jsonDecode(pokemon);
      return decodedPokemon['id'] == id;
    });
  }

//To get all the captured pokemon from the local
  Future<List<Pokemon>> getCaughtPokemons() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> caughtPokemons = prefs.getStringList(caughtPokemonsKey) ?? [];
    return caughtPokemons.map((pokemon) {
      var jsonPokemon = jsonDecode(pokemon);
      var detailedPokemon = Pokemon.fromJson(jsonPokemon);
      detailedPokemon.updateFromDetailJson(jsonPokemon);
      return detailedPokemon;
    }).toList();
  }
}
