import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/strings.dart';

class PokemonDetail {
  final String name;
  final String imageUrl;
  final List<String> types;

  PokemonDetail({required this.name, required this.imageUrl, required this.types});

  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    return PokemonDetail(
      name: json['name'],
      imageUrl: json['sprites']['other']['official-artwork']['front_default'],
      types: (json['types'] as List).map((e) => e['type']['name'] as String).toList(),
    );
  }

  static final Map<String, PokemonDetail> _cache = {};

  static Future<PokemonDetail> fetchDetail(String url) async {
    if (_cache.containsKey(url)) {
      return _cache[url]!;
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      PokemonDetail pokemonDetail = PokemonDetail.fromJson(json.decode(response.body));
      _cache[url] = pokemonDetail;
      return pokemonDetail;
    } else {
      throw Exception(AppStrings.errorLoadingPokemonDetails);
    }
  }
}
