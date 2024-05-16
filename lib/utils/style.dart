import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokedex/utils/constants.dart';

class Style {
  static const Color lightBlue = Color(0xFF81D4FA);

  //Colors of pokemon types
  static const Color bostonRed = Color(0xFFCC0000);
  static const Color bug = Color(0xFF94BC4A);
  static const Color dark = Color(0xFF736C75);
  static const Color dragon = Color(0xFF6A7BAF);
  static const Color electric = Color(0xFFE5C531);
  static const Color fairy = Color(0xFFE397D1);
  static const Color fighting = Color(0xFFCB5F48);
  static const Color fire = Color(0xFFEA7A3C);
  static const Color flying = Color(0xFF7DA6DE);
  static const Color ghost = Color(0xFF846AB6);
  static const Color grass = Color(0xFF71C558);
  static const Color ground = Color(0xFFCC9F4F);
  static const Color ice = Color(0xFF70CBD4);
  static const Color normal = Color(0xFFAAB09F);
  static const Color poison = Color(0xFFB468B7);
  static const Color psychic = Color(0xFFE5709B);
  static const Color rock = Color(0xFFB2A061);
  static const Color steel = Color(0xFF89A1B0);
  static const Color water = Color(0xFF539AE2);
  static Color getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case Types.bug:
        return bug;
      case Types.dark:
        return dark;
      case Types.dragon:
        return dragon;
      case Types.electric:
        return electric;
      case Types.fairy:
        return fairy;
      case Types.fighting:
        return fighting;
      case Types.fire:
        return fire;
      case Types.flying:
        return flying;
      case Types.ghost:
        return ghost;
      case Types.grass:
        return grass;
      case Types.ground:
        return ground;
      case Types.ice:
        return ice;
      case Types.normal:
        return normal;
      case Types.poison:
        return poison;
      case Types.psychic:
        return psychic;
      case Types.rock:
        return rock;
      case Types.steel:
        return steel;
      case Types.water:
        return water;
      default:
        return Colors.redAccent;
    }
  }

  static IconData getTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case Types.bug:
        return Icons.bug_report;
      case Types.dark:
        return Icons.nightlight_round;
      case Types.dragon:
        return Icons.pets;
      case Types.electric:
        return Icons.flash_on;
      case Types.fairy:
        return Icons.filter_vintage;
      case Types.fighting:
        return Icons.sports_mma;
      case Types.fire:
        return Icons.local_fire_department;
      case Types.flying:
        return Icons.flight;
      case Types.ghost:
        return Icons.emoji_emotions;
      case Types.grass:
        return Icons.grass;
      case Types.ground:
        return Icons.landscape;
      case Types.ice:
        return Icons.ac_unit;
      case Types.normal:
        return Icons.accessibility;
      case Types.poison:
        return Icons.science;
      case Types.psychic:
        return Icons.psychology;
      case Types.rock:
        return Icons.terrain;
      case Types.steel:
        return Icons.build;
      case Types.water:
        return Icons.water;
      default:
        return Icons.help_outline;
    }
  }
}

TextStyle pokedexTextStyle = TextStyle(
  fontFamily: 'PokemonSolid',
  fontSize: 21.sp,
  color: Colors.black,
);
