import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pokedex/data/api_service.dart';
import 'package:pokedex/data/pokedex_service.dart';
import 'package:pokedex/utils/constants.dart';
import 'package:pokedex/utils/style.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.white,
        ),
        Align(
          alignment: Alignment.center,
          child: Image.asset(
            'assets/images/splash_logo.png',
            width: 350.w,
            semanticLabel: 'Logo',
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 5.0.h),
              child: const SafeArea(
                bottom: true,
                child: LinearProgressIndicator(
                  color: Style.bostonRed,
                ),
              ),
            ))
      ],
    );
  }

  Future _loadData() async {
    log('starting services ...');
    await Future.delayed(const Duration(seconds: 3));
    Get.put(Api(), permanent: true);
    Get.put(PokedexService(), permanent: true);
    PokedexService pokedexService = Get.find();
    pokedexService.init();
    Get.offAllNamed(AppRoutes.pokedex);
  }
}
