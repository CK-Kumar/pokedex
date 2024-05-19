import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pokedex/controllers/pokedex_controller.dart';
import 'package:pokedex/models/pokemon_model.dart';
import 'package:pokedex/utils/style.dart';

class CapturedPokemonCard extends StatelessWidget {
  const CapturedPokemonCard(
      {super.key, required this.pokemon, required this.onTap});

  final Pokemon pokemon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final PokedexController controller = Get.find();
    return Card(
      color: pokemon.typesRx.isEmpty
          ? Colors.white
          : Style.getTypeColor(pokemon.typesRx.first),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0.w),
        side: BorderSide(
          color: Colors.black,
          width: 3.w,
        ),
      ),
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.2),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '#${pokemon.idRx.value}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23.sp,
              ),
            ),
            SizedBox(height: 5.h),
            Obx(() {
              return pokemon.imageUrlRx.value.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: pokemon.imageUrlRx.value,
                      width: 100.w,
                      height: 100.h,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => CircularProgressIndicator(
                        color: controller.pokedexColor.value,
                        value: null,
                      ),
                      errorWidget: (context, url, error) => Icon(
                        Icons.error,
                        color: Colors.black,
                        size: 100.h,
                      ),
                    )
                  : CircularProgressIndicator(
                      color: controller.pokedexColor.value,
                    );
            }),
            SizedBox(height: 5.h),
            Text(
              pokemon.name.capitalizeFirst!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
