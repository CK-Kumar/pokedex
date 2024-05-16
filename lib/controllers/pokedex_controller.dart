import 'package:get/get.dart';
import 'package:pokedex/data/pokedex_service.dart';
import 'package:pokedex/models/pokemon_model.dart';

import 'package:pokedex/utils/constants.dart';

class PokedexController extends GetxController {
  final PokedexService pokedexService = Get.find();
  RxList<Pokemon> pokemonList = <Pokemon>[].obs;
  RxList<Pokemon> displayedPokemon = <Pokemon>[].obs;
  RxList<Pokemon> capturedPokemonList = <Pokemon>[].obs;
  RxBool isLoading = false.obs;
  RxBool isCaught = false.obs;

  void loadPokemons() async {
    isLoading.value = true;
    pokemonList.value = pokedexService.pokemons;
    displayedPokemon.value = pokemonList;
    isLoading.value = false;
  }

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
  }

  void checkIfCaught(int pokemonId) async {
    isCaught.value = await pokedexService.isPokemonCaught(pokemonId);
  }

  void loadCapturedPokemons() async {
    capturedPokemonList.value = await pokedexService.getCaughtPokemons();
  }

  goToExploreScreen() {
    Get.toNamed(AppRoutes.pokemonSearch);
  }

  goToCapturedPokemonScreen() {
    Get.toNamed(AppRoutes.capturedPokemon);
  }
}
