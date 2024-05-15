import 'package:get/get.dart';
import 'package:pokedex/controllers/pokedex_controller.dart';
import 'package:pokedex/ui/screens/pokedex/pokedex_screen.dart';
import 'package:pokedex/ui/screens/pokedex/splash_screen.dart';
import 'package:pokedex/ui/screens/pokemon/captured_pokemon_screen.dart';
import 'package:pokedex/ui/screens/pokemon/pokemon_details_screen.dart';
import 'package:pokedex/ui/screens/pokemon/pokemon_search_screen.dart';
import 'package:pokedex/utils/constants.dart';

class AppScreens {
  static final screens = [
    GetPage(
        name: AppRoutes.splash,
        page: () {
          return const SplashScreen();
        }),
    GetPage(
        name: AppRoutes.pokedex,
        page: () {
          Get.put(PokedexController());
          return const PokedexScreen();
        }),
    GetPage(
        name: AppRoutes.pokemonSearch,
        page: () {
          Get.put(PokedexController());
          return const PokemonSearchScreen();
        }),
    GetPage(
        name: AppRoutes.capturedPokemon,
        page: () {
          return const CapturedPokemonScreen();
        }),
    GetPage(
        name: AppRoutes.pokemonDetails,
        page: () {
          return const PokemonDetailsScreen();
        }),
  ];
}
