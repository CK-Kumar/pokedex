import 'package:get/get.dart';
import 'package:pokedex/data/pokedex_service.dart';
import 'package:pokedex/models/pokemon_model.dart';
import 'package:pokedex/utils/constants.dart';

class PokedexController extends GetxController {
  final PokedexService pokedexService = Get.find();
  RxList<Pokemon> pokemonList = <Pokemon>[].obs;
  RxList<Pokemon> displayedPokemon = <Pokemon>[].obs;
  RxBool isLoading = false.obs;

  void loadPokemons() async {
    isLoading.value = true;
    await pokedexService.getPokemons();
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
              pokemon.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  void resetSearch() {
    filterPokemon('');
  }

  goToExploreScreen() {
    Get.toNamed(AppRoutes.pokemonSearch);
  }

  goToCapturedPokemonScreen() {
    Get.toNamed(AppRoutes.capturedPokemon);
  }
}
