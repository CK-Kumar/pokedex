import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pokedex/models/pokemon_model.dart';
import 'package:pokedex/utils/style.dart';

class PokemonSearchTile extends StatelessWidget {
  final Pokemon pokemon;
  final void Function()? onTap;
  const PokemonSearchTile(
      {super.key, required this.pokemon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
      child: ListTile(
        leading: Obx(() {
          return pokemon.imageUrlRx.value.isNotEmpty
              ? Image.network(
                  pokemon.imageUrlRx.value,
                  width: 50.w,
                  height: 50.h,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return SizedBox(
                        width: 30.w,
                        height: 30.h,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Style.bostonRed,
                        ),
                      );
                    }
                  },
                )
              : SizedBox(
                  width: 30.w,
                  height: 30.h,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Style.bostonRed,
                  ),
                );
        }),
        title: Center(
          child: Text(
            pokemon.name.capitalizeFirst.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19.sp),
          ),
        ),
        trailing: const Icon(
          Icons.catching_pokemon,
          color: Style.bostonRed,
        ),
        onTap: onTap,
      ),
    );
  }
}
