import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokedex/utils/style.dart';

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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          labelText: 'Search Pokémon',
          labelStyle: const TextStyle(color: Style.bostonRed),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0.w),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Style.bostonRed),
            borderRadius: BorderRadius.circular(12.0),
          ),
          prefixIcon: const Icon(Icons.search, color: Style.bostonRed),
          suffixIcon: IconButton(
              icon: const Icon(Icons.clear, color: Style.bostonRed),
              onPressed: onPressed),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
