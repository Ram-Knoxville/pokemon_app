import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/pokemon_team_provider.dart';
import '../../models/pokemon_detail.dart';
import '../../utils/pokemon_type_colors.dart';
import '../../utils/strings.dart';

class TeamScreen extends StatelessWidget {
  const TeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.myTeamTitle),
        backgroundColor: Colors.grey,
      ),
      body: Consumer<PokemonTeamProvider>(
        builder: (context, provider, child) {
          List<PokemonDetail> team = provider.team;

          if (team.isEmpty) {
            return const Center(child: Text(AppStrings.noPokemonInTeam));
          }

          return ListView.builder(
            itemCount: team.length,
            itemBuilder: (context, index) {
              PokemonDetail currentPokemon = team[index];

              return GestureDetector(
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(currentPokemon.name),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.network(currentPokemon.imageUrl),
                            ...currentPokemon.types.map((type) {
                              return Container(
                                padding: const EdgeInsets.all(4.0),
                                margin: const EdgeInsets.only(top: 4.0),
                                color: PokemonTypeColors.getColor(type),
                                child: Text(type),
                              );
                            }).toList(),
                          ],
                        ),
                        actions: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                            onPressed: () {
                              provider.removePokemonFromTeam(currentPokemon);
                              Navigator.pop(context);
                            },
                            child: const Text(AppStrings.removeFromTeam),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(AppStrings.close),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  color: Colors.grey[300],
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        color: Colors.white,
                        child: Image.network(currentPokemon.imageUrl, fit: BoxFit.contain),
                      ),
                      const SizedBox(width: 8.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(currentPokemon.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                          Wrap(
                            children: currentPokemon.types.map((type) {
                              return Container(
                                padding: const EdgeInsets.all(4.0),
                                margin: const EdgeInsets.only(right: 4.0, top: 2.0),
                                color: PokemonTypeColors.getColor(type),
                                child: Text(type),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
