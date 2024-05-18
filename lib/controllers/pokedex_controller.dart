import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/data/pokedex_service.dart';
import 'package:pokedex/models/pokemon_model.dart';
import 'package:pokedex/utils/constants.dart';
import 'package:pokedex/utils/style.dart';

class PokedexController extends GetxController {
  final PokedexService pokedexService = Get.find();
  RxList<Pokemon> pokemonList = <Pokemon>[].obs;
  RxList<Pokemon> displayedPokemon = <Pokemon>[].obs;
  RxList<Pokemon> capturedPokemonList = <Pokemon>[].obs;
  RxList<Pokemon> capturedDisplayedPokemonList = <Pokemon>[].obs;
  RxBool isLoading = false.obs;
  RxBool isCaught = false.obs;
  RxBool isSortedByName = false.obs;
  RxString selectedType = ''.obs;
  Rx<Color> pokedexColor = Style.bostonRed.obs;

//To load all the pokemons
  void loadPokemons() async {
    isLoading.value = true;
    pokemonList.value = pokedexService.pokemons;
    displayedPokemon.value = pokemonList;
    isLoading.value = false;
  }

//Filtering based on the search
  void filterPokemon(String query) {
    if (query.isEmpty) {
      displayedPokemon.value = pokemonList;
    } else {
      displayedPokemon.value = pokemonList
          .where((pokemon) =>
              pokemon.name.toLowerCase().startsWith(query.toLowerCase()))
          .toList();
    }
  }

  void resetSearch() {
    filterPokemon('');
  }

  void toggleCatchPokemon(Pokemon pokemon) async {
    if (isCaught.value) {
      await pokedexService.removePokemon(pokemon.id);
    } else {
      await pokedexService.savePokemon(pokemon);
    }
    isCaught.value = !isCaught.value;
    loadCapturedPokemons();
  }

  void checkIfCaught(int pokemonId) async {
    isCaught.value = await pokedexService.isPokemonCaught(pokemonId);
  }

//This method is to load the captured pokemon stored in local
  loadCapturedPokemons() async {
    isLoading.value = true;
    capturedPokemonList.value = await pokedexService.getCaughtPokemons();
    sortAndFilterPokemons();
    updatePokedexColor();
    isLoading.value = false;
  }

//Sort and filter the captured pokemon page based on the user response
  void sortAndFilterPokemons() {
    var tempList = capturedPokemonList.where((pokemon) {
      return selectedType.isEmpty || pokemon.types.contains(selectedType.value);
    }).toList();

    if (isSortedByName.value) {
      tempList.sort((a, b) => a.name.compareTo(b.name));
    } else {
      tempList.sort((a, b) => a.id.compareTo(b.id));
    }

    capturedDisplayedPokemonList.value = tempList;
  }

//To update the podedex color based on the majority of the types
  void updatePokedexColor() {
    Map<String, int> typeCount = {};

    for (var pokemon in capturedPokemonList) {
      for (var type in pokemon.types) {
        if (typeCount.containsKey(type)) {
          typeCount[type] = typeCount[type]! + 1;
        } else {
          typeCount[type] = 1;
        }
      }
    }

    if (typeCount.isEmpty) {
      pokedexColor.value = Style.bostonRed;
      return;
    }

    var sortedTypes = typeCount.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

//To find the majority considering some pokemon has multiple types
    if (sortedTypes.length > 1 &&
        sortedTypes[0].value == sortedTypes[1].value) {
      pokedexColor.value = Style.bostonRed;
    } else {
      pokedexColor.value = Style.getTypeColor(sortedTypes[0].key);
    }
  }

  refreshCapturedPokemons() async {
    await loadCapturedPokemons();
  }

  void filterByType(String type) {
    selectedType.value = type;
    sortAndFilterPokemons();
  }

  void toggleSort() {
    isSortedByName.value = !isSortedByName.value;
    sortAndFilterPokemons();
  }

  void goToExploreScreen() {
    Get.toNamed(AppRoutes.pokemonSearch);
  }

  void goToCapturedPokemonScreen() {
    Get.toNamed(AppRoutes.capturedPokemon);
  }
}
