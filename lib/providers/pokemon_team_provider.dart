import 'package:flutter/material.dart';
import '../models/pokemon_detail.dart';
import '../utils/strings.dart';

class PokemonTeamProvider with ChangeNotifier {
  final List<PokemonDetail> _team = [];

  List<PokemonDetail> get team => _team;

  String? addPokemonToTeam(PokemonDetail pokemon) {
    if (_team.contains(pokemon)) {
      return AppStrings.alreadyPartOfTeam;
    }
    if (_team.length >= 5) {
      return AppStrings.completedTeam;
    }
    _team.add(pokemon);
    notifyListeners();
    return null;
  }

  void removePokemonFromTeam(PokemonDetail pokemon) {
    _team.remove(pokemon);
    notifyListeners();
  }
}
