import 'dart:convert';
import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/utils/constants.dart';

class Api extends GetxService {
  Future<String> _getApi(String url) async {
    Uri uri = Uri.parse(url);
    final http.Response response = await http.get(uri);
    return utf8.decode(response.bodyBytes);
  }

  Future<String> getPokemons(String limit) async {
    try {
      var response = await _getApi(
          '${EndPoints.baseUrl}${EndPoints.pokemon}?limit=$limit');
      return response;
    } catch (e) {
      log('Error de url: $e');
      return '{"error": "$e"}';
    }
  }

  Future<String> getPokemonDetails(String url) async {
    try {
      var response = await _getApi(url);
      return response;
    } catch (e) {
      log('Error fetching pokemon details: $e');
      return '{"error": "$e"}';
    }
  }
}
