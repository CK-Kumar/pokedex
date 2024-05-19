import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pokedex/controllers/pokedex_controller.dart';
import 'package:pokedex/models/pokemon_model.dart';

class PokemonSearchTile extends StatelessWidget {
  final Pokemon pokemon;
  final void Function()? onTap;
  const PokemonSearchTile(
      {super.key, required this.pokemon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final PokedexController controller = Get.find();
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
      child: ListTile(
        leading: Obx(() {
          return pokemon.imageUrlRx.value.isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: pokemon.imageUrlRx.value,
                  width: 50.w,
                  height: 50.h,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => SizedBox(
                    width: 30.w,
                    height: 30.h,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: controller.pokedexColor.value,
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.error,
                    color: Colors.black,
                    size: 30.h,
                  ),
                )
              : SizedBox(
                  width: 30.w,
                  height: 30.h,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: controller.pokedexColor.value,
                  ),
                );
        }),
        title: Center(
          child: Text(
            pokemon.name.capitalizeFirst.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19.sp),
          ),
        ),
        trailing: Icon(
          Icons.catching_pokemon,
          color: controller.pokedexColor.value,
        ),
        onTap: onTap,
      ),
    );
  }
}
