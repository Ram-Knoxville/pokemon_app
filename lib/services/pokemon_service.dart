import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon.dart';
import '../utils/strings.dart';

class PokemonService {
  static const baseUrl = 'https://pokeapi.co/api/v2';

  Future<List<Pokemon>> fetchPokemonList(int offset, int limit) async {
    final response = await http.get(Uri.parse('$baseUrl/pokemon?limit=$limit&offset=$offset'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      Iterable list = data['results'];
      return list.map((model) => Pokemon.fromJson(model)).toList();
    } else {
      throw Exception(AppStrings.errorLoadingPokemonList);
    }
  }

}
