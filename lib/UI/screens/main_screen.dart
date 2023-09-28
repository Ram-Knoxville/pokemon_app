import 'package:flutter/material.dart';
import 'package:pokemon_app/UI/screens/team_screen.dart';
import 'package:provider/provider.dart';
import '../../providers/pokemon_team_provider.dart';
import '../../ui/widgets/pokemon_list_widget.dart';
import '../../utils/strings.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PokemonAppBar(),
      body: PokemonListWidget(),
    );
  }
}

class PokemonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PokemonAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(AppStrings.pokemonListTitle),
      actions: const [
        TeamIconButton(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class TeamIconButton extends StatelessWidget {
  const TeamIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    int teamCount = Provider.of<PokemonTeamProvider>(context).team.length;

    return Stack(
      children: [
        IconButton(
          icon: const Icon(Icons.sports_baseball),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TeamScreen()),
            );
          },
        ),
        Positioned(
          right: 8,
          top: 8,
          child: CircleAvatar(
            radius: 8,
            backgroundColor: Colors.red,
            child: Text(
              '$teamCount',
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }
}

