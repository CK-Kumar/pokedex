import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pokedex/controllers/pokedex_controller.dart';
import 'package:pokedex/ui/screens/pokemon/pokemon_details_screen.dart';
import 'package:pokedex/ui/widgets/pokedex/pokemon_search.dart';
import 'package:pokedex/ui/widgets/pokedex/pokemon_search_tile.dart';
import 'package:pokedex/utils/style.dart';

class PokemonSearchScreen extends StatefulWidget {
  const PokemonSearchScreen({super.key});

  @override
  State<PokemonSearchScreen> createState() => _PokemonSearchScreenState();
}

class _PokemonSearchScreenState extends State<PokemonSearchScreen> {
  final PokedexController controller = Get.find();
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.loadPokemons();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Explore Pokémon',
                style: pokedexTextStyle,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          backgroundColor: Style.bostonRed,
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: Style.bostonRed),
            );
          } else {
            return Column(
              children: [
                PokemonSearch(
                    searchController: searchController,
                    onPressed: () {
                      searchController.clear();
                      controller.resetSearch();
                    },
                    onChanged: controller.filterPokemon),
                Expanded(
                  child: Obx(() {
                    if (controller.displayedPokemon.isEmpty) {
                      return Center(
                        child: Text(
                          'Oops..No Pokémon found in Kanto',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20.sp),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: controller.displayedPokemon.length,
                        itemBuilder: (context, index) {
                          final pokemon = controller.displayedPokemon[index];
                          return PokemonSearchTile(
                              pokemon: pokemon,
                              onTap: () {
                                Navigator.of(Get.context!).push(
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        PokemonDetailsScreen(
                                      pokemon: pokemon,
                                    ),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      const begin = Offset(0.0, 1.0);
                                      const end = Offset.zero;
                                      const curve = Curves.ease;

                                      var tween = Tween(begin: begin, end: end)
                                          .chain(CurveTween(curve: curve));
                                      var offsetAnimation =
                                          animation.drive(tween);

                                      return SlideTransition(
                                        position: offsetAnimation,
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              });
                        },
                      );
                    }
                  }),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
