import 'package:flutter/material.dart';

class PokemonTypeColors {
  static Map<String, Color> typeColor = {
    'normal': Colors.brown[400]!,
    'fire': Colors.red,
    'water': Colors.blue,
    'electric': Colors.yellow,
    'grass': Colors.green,
    'ice': Colors.cyanAccent[400]!,
    'fighting': Colors.deepOrange,
    'poison': Colors.purple,
    'ground': Colors.brown,
    'flying': Colors.blue[50]!,
    'psychic': Colors.pink,
    'bug': Colors.lightGreen[500]!,
    'rock': Colors.grey,
    'ghost': Colors.indigo[400]!,
    'dark': Colors.brown[900]!,
    'dragon': Colors.indigo[800]!,
    'steel': Colors.grey[600]!,
    'fairy': Colors.pinkAccent[100]!,
  };

  static Color getColor(String type) {
    return typeColor[type] ?? Colors.grey;
  }
}
