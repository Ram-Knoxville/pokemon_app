import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/pokemon_team_provider.dart';
import 'ui/screens/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PokemonTeamProvider(),
      child: MaterialApp(
        home: MainScreen(),
      ),
    );
  }
}
