import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pokedex/ui/screens/app_screens.dart';
import 'package:pokedex/utils/constants.dart';

class PokedexApp extends StatelessWidget {
  const PokedexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        builder: (BuildContext context, Widget? child) {
          final MediaQueryData data = MediaQuery.of(context);
          return MediaQuery(
            data: data.copyWith(textScaler: const TextScaler.linear(1)),
            child: child!,
          );
        },
        title: 'PokeDex',
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splash,
        getPages: AppScreens.screens,
      ),
    );
  }
}
