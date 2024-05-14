import 'package:get/get.dart';
import 'package:pokedex/utils/constants.dart';

class PokedexController extends GetxController {
  goToExploreScreen() {
    Get.toNamed(AppRoutes.pokemonSearch);
  }

  goToCapturedPokemonScreen() {
    Get.toNamed(AppRoutes.capturedPokemon);
  }
}
