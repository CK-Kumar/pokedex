import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pokedex/models/pokemon_model.dart';
import 'package:pokedex/utils/style.dart';

class CapturedPokemonCard extends StatelessWidget {
  const CapturedPokemonCard(
      {super.key, required this.pokemon, required this.onTap});

  final Pokemon pokemon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
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
                  ? Image.network(
                      pokemon.imageUrlRx.value,
                      width: 100.w,
                      height: 100.h,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return CircularProgressIndicator(
                            color: Style.bostonRed,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          );
                        }
                      },
                    )
                  : const CircularProgressIndicator(
                      color: Style.bostonRed,
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
