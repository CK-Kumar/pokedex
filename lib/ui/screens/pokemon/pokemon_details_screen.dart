import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pokedex/controllers/pokedex_controller.dart';
import 'package:pokedex/models/pokemon_model.dart';
import 'package:pokedex/utils/style.dart';

class PokemonDetailsScreen extends StatelessWidget {
  const PokemonDetailsScreen({super.key, required this.pokemon});
  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    final PokedexController controller = Get.put(PokedexController());
    return SafeArea(
      top: false,
      child: Obx(() {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  pokemon.name,
                  style: pokedexTextStyle.copyWith(fontSize: 40.sp),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            backgroundColor: pokemon.typesRx.isEmpty
                ? Colors.white
                : Style.getTypeColor(pokemon.typesRx.first),
          ),
          body: pokemon.imageUrlRx.value.isEmpty ||
                  pokemon.idRx.value == 0 ||
                  pokemon.heightRx.value == 0 ||
                  pokemon.weightRx.value == 0 ||
                  pokemon.typesRx.isEmpty
              ? Center(
                  child: CircularProgressIndicator(
                      color: controller.pokedexColor.value),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 450.h,
                        decoration: BoxDecoration(
                          color: pokemon.types.isNotEmpty
                              ? Style.getTypeColor(pokemon.typesRx.first)
                              : Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40.0.w),
                            bottomRight: Radius.circular(40.0.w),
                          ),
                        ),
                        child: Center(
                          child: CachedNetworkImage(
                            imageUrl: pokemon.highResolutionUrlRx.value,
                            height: 300.h,
                            fit: BoxFit.fitHeight,
                            placeholder: (context, url) => SizedBox(
                              height: 300.h,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: controller.pokedexColor.value,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Icon(
                              Icons.error,
                              color: Colors.black,
                              size: 300.h,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              spacing: 12.w,
                              runSpacing: 12.h,
                              children: [
                                _buildAttributeChip(
                                  icon: Icons.tag,
                                  label: pokemon.idRx.value
                                      .toString()
                                      .padLeft(3, '0'),
                                  typeColor:
                                      Style.getTypeColor(pokemon.typesRx.first),
                                ),
                                _buildAttributeChip(
                                  icon: Icons.height,
                                  label:
                                      'Height ${(pokemon.heightRx.value / 10).toStringAsFixed(1)} m',
                                  typeColor: Colors.blueAccent,
                                ),
                                _buildAttributeChip(
                                  icon: Icons.monitor_weight,
                                  label:
                                      'Weight ${(pokemon.weightRx.value / 10).toStringAsFixed(1)} kg',
                                  typeColor: Colors.orangeAccent,
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            Row(
                              children: pokemon.types.map((type) {
                                return Container(
                                  margin: EdgeInsets.only(right: 8.w),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.w, vertical: 6.h),
                                  decoration: BoxDecoration(
                                    color: Style.getTypeColor(type),
                                    borderRadius: BorderRadius.circular(20.w),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Style.getTypeIcon(type),
                                        color: Colors.white,
                                        size: 20.w,
                                      ),
                                      SizedBox(width: 5.w),
                                      Text(
                                        type.capitalizeFirst!,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: 16.h),
                            _buildCatchReleaseButton(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        );
      }),
    );
  }

  Widget _buildCatchReleaseButton() {
    final PokedexController controller = Get.put(PokedexController());
    controller.checkIfCaught(pokemon.idRx.value);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(20.w),
          child: Obx(() => Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        controller.isCaught.value ? Colors.red : Colors.green,
                    padding:
                        EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(
                        color: Colors.black,
                        width: 2.0.w,
                      ),
                    ),
                  ),
                  onPressed: () {
                    controller.toggleCatchPokemon(pokemon);
                    controller.loadCapturedPokemons();
                  },
                  child: Text(
                    controller.isCaught.value ? "Release 'em" : "Catch 'em",
                    style: TextStyle(
                      fontSize: 23.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              )),
        ),
      ],
    );
  }

  Widget _buildAttributeChip({
    required IconData icon,
    required String label,
    required Color typeColor,
  }) {
    return Chip(
      avatar: Icon(icon, color: Colors.white),
      label: Text(label,
          style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500)),
      backgroundColor: typeColor,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
    );
  }
}
