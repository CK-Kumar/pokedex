import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pokedex/controllers/pokedex_controller.dart';
import 'package:pokedex/models/pokemon_model.dart';
import 'package:pokedex/ui/screens/pokemon/pokemon_details_screen.dart';
import 'package:pokedex/ui/widgets/pokedex/captured_pokemon_card.dart';
import 'package:pokedex/utils/constants.dart';
import 'package:pokedex/utils/style.dart';

class CapturedPokemonScreen extends StatelessWidget {
  const CapturedPokemonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PokedexController controller = Get.find();

    controller.loadCapturedPokemons();

    List<String> types = [
      '',
      Types.bug,
      Types.dark,
      Types.dragon,
      Types.electric,
      Types.fairy,
      Types.fighting,
      Types.fire,
      Types.flying,
      Types.ghost,
      Types.grass,
      Types.ground,
      Types.ice,
      Types.normal,
      Types.poison,
      Types.psychic,
      Types.rock,
      Types.steel,
      Types.water
    ];

    return SafeArea(
      top: false,
      child: Obx(() {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Captured Pokémon',
                  style: pokedexTextStyle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            backgroundColor: controller.pokedexColor.value,
            actions: [
              PopupMenuButton<String>(
                icon: Icon(
                  controller.selectedType.isEmpty
                      ? Icons.filter_alt_outlined
                      : Icons.filter_alt,
                  size: 28.sp,
                  color: Colors.black,
                ),
                onSelected: (String result) {
                  controller.filterByType(result);
                },
                itemBuilder: (BuildContext context) {
                  return types.map((type) {
                    return PopupMenuItem<String>(
                      value: type,
                      child: Text(
                        type.isEmpty ? 'All Types' : type.capitalizeFirst!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: controller.selectedType.value == type
                              ? controller.pokedexColor.value
                              : Colors.black,
                        ),
                      ),
                    );
                  }).toList();
                },
              ),
              IconButton(
                icon: Icon(
                  controller.isSortedByName.value
                      ? Icons.sort_by_alpha
                      : Icons.sort,
                  size: 28.sp,
                  color: Colors.black,
                ),
                onPressed: () {
                  controller.toggleSort();
                },
              ),
            ],
          ),
          body: controller.capturedDisplayedPokemonList.isEmpty
              ? Center(
                  child: Text(
                    "Oops... Gotta Catch 'em All",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20.sp,
                    ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(
                      top: 15.h, left: 10.h, right: 10.h, bottom: 10.h),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 13.w,
                      mainAxisSpacing: 13.h,
                    ),
                    itemCount: controller.capturedDisplayedPokemonList.length,
                    itemBuilder: (context, index) {
                      Pokemon pokemon =
                          controller.capturedDisplayedPokemonList[index];
                      return CapturedPokemonCard(
                        pokemon: pokemon,
                        onTap: () {
                          Navigator.of(Get.context!).push(
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      PokemonDetailsScreen(pokemon: pokemon),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                var scaleAnimation =
                                    Tween(begin: 0.0, end: 1.0).animate(
                                  CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.easeInOut,
                                  ),
                                );

                                return ScaleTransition(
                                  scale: scaleAnimation,
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
        );
      }),
    );
  }
}
