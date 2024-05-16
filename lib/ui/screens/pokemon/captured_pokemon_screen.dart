import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/controllers/pokedex_controller.dart';
import 'package:pokedex/models/pokemon_model.dart';
import 'package:pokedex/ui/screens/pokemon/pokemon_details_screen.dart';

class CapturedPokemonScreen extends StatelessWidget {
  const CapturedPokemonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PokedexController controller = Get.put(PokedexController());

    // Load captured Pokémon when the screen is displayed
    controller.loadCapturedPokemons();

    return Scaffold(
      appBar: AppBar(
        title: Text('Captured Pokémon'),
      ),
      body: Obx(() {
        if (controller.capturedPokemonList.isEmpty) {
          return Center(
            child: Text('No Pokémon captured yet.'),
          );
        }

        return ListView.builder(
          itemCount: controller.capturedPokemonList.length,
          itemBuilder: (context, index) {
            Pokemon pokemon = controller.capturedPokemonList[index];
            return ListTile(
              leading: Image.network(pokemon.imageUrlRx.value),
              title: Text(pokemon.name),
              subtitle: Text('ID: ${pokemon.idRx.value}'),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  controller.toggleCatchPokemon(pokemon);
                  controller.loadCapturedPokemons(); // Refresh list
                },
              ),
              onTap: () {
                // Navigate to details screen
                Get.to(() => PokemonDetailsScreen(pokemon: pokemon));
              },
            );
          },
        );
      }),
    );
  }
}
