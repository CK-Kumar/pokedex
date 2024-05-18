import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pokedex/controllers/pokedex_controller.dart';
import 'package:pokedex/ui/widgets/painter/pokedex_painter.dart';
import 'package:pokedex/ui/widgets/pokedex/pokedex_button.dart';
import 'package:pokedex/utils/style.dart';

class PokedexScreen extends StatefulWidget {
  const PokedexScreen({super.key});

  @override
  State<PokedexScreen> createState() => _PokedexScreenState();
}

class _PokedexScreenState extends State<PokedexScreen> {
  PokedexController controller = Get.find();

  @override
  void initState() {
    super.initState();
    _initializePokedexScreen();
  }

  _initializePokedexScreen() async {
    await controller.loadCapturedPokemons();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SafeArea(
        child: Scaffold(
          backgroundColor: controller.pokedexColor.value,
          body: Center(
            child: Stack(
              children: [
                CustomPaint(
                  size: Size(411.w, 844.h),
                  painter: PokedexPainter(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 200.h, left: 15.w, right: 15.w),
                  child: Container(
                    height: 260.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(width: 3.w),
                      gradient: const LinearGradient(
                        colors: [
                          Colors.white,
                          Style.lightBlue,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20.w),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: const Offset(0, 4),
                          blurRadius: 4.w,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Welcome Ash!', style: pokedexTextStyle),
                          Padding(
                            padding: EdgeInsets.all(5.0.h),
                            child: PokedexButton(
                              text: 'Explore Kanto!',
                              onPressed: controller.goToExploreScreen,
                              icon: Icons.search,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5.0.h),
                            child: PokedexButton(
                              text: 'Captured Pokémon',
                              onPressed: controller.goToCapturedPokemonScreen,
                              icon: Icons.catching_pokemon,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
