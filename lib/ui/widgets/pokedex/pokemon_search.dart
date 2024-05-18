import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pokedex/controllers/pokedex_controller.dart';

class PokemonSearch extends StatelessWidget {
  const PokemonSearch({
    super.key,
    required this.searchController,
    required this.onPressed,
    required this.onChanged,
  });

  final TextEditingController searchController;
  final void Function(String)? onChanged;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final PokedexController controller = Get.find();
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: searchController,
          decoration: InputDecoration(
            labelText: 'Search Pokémon',
            labelStyle: TextStyle(color: controller.pokedexColor.value),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0.w),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: controller.pokedexColor.value),
              borderRadius: BorderRadius.circular(12.0.w),
            ),
            prefixIcon:
                Icon(Icons.search, color: controller.pokedexColor.value),
            suffixIcon: IconButton(
              icon: Icon(Icons.clear, color: controller.pokedexColor.value),
              onPressed: onPressed,
            ),
          ),
          onChanged: onChanged,
        ),
      );
    });
  }
}
