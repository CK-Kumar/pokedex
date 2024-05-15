import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/controllers/pokedex_controller.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Style.bostonRed),
          );
        } else {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    labelText: 'Search Pokémon',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        searchController.clear();
                        controller.resetSearch();
                      },
                    ),
                  ),
                  onChanged: controller.filterPokemon,
                ),
              ),
              Expanded(
                child: Obx(() {
                  if (controller.displayedPokemon.isEmpty) {
                    return const Center(
                      child: Text('No Pokémon found'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: controller.displayedPokemon.length,
                      itemBuilder: (context, index) {
                        final pokemon = controller.displayedPokemon[index];
                        return ListTile(
                          title: Text(pokemon.name),
                          onTap: () {},
                        );
                      },
                    );
                  }
                }),
              ),
            ],
          );
        }
      }),
    );
  }
}
