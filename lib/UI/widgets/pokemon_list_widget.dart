import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/pokemon.dart';
import '../../models/pokemon_detail.dart';
import '../../services/pokemon_service.dart';
import '../../providers/pokemon_team_provider.dart';
import '../../utils/pokemon_type_colors.dart';
import '../../utils/strings.dart';

class PokemonListWidget extends StatefulWidget {
  const PokemonListWidget({super.key});

  @override
  _PokemonListWidgetState createState() => _PokemonListWidgetState();
}

class _PokemonListWidgetState extends State<PokemonListWidget> {
  late List<Pokemon> pokemons;
  final _scrollController = ScrollController();
  final _pokemonService = PokemonService();
  int _offset = 0;

  @override
  void initState() {
    super.initState();
    pokemons = [];
    _fetchPokemonList();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _fetchPokemonList();
      }
    });
  }

  _fetchPokemonList() async {
    List<Pokemon> newPokemons = await _pokemonService.fetchPokemonList(_offset, 10);
    setState(() {
      pokemons.addAll(newPokemons);
      _offset += 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: pokemons.length,
      itemBuilder: (context, index) => PokemonListItem(pokemons[index]),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}


class PokemonListItem extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonListItem(this.pokemon, {super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PokemonDetail>(
      future: PokemonDetail.fetchDetail(pokemon.url),
      builder: (context, detailSnapshot) {
        if (detailSnapshot.connectionState == ConnectionState.waiting) {
          return const ListTile(title: Text(AppStrings.loading));
        } else if (detailSnapshot.hasError) {
          return const ListTile(title: Text(AppStrings.errorLoadingPokemonDetails));
        } else {
          PokemonDetail currentPokemon = detailSnapshot.data!;
          bool isPartOfTeam = Provider.of<PokemonTeamProvider>(context).team.contains(currentPokemon);

          return Container(
            color: Colors.grey[300],
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                const SizedBox(height: 8.0),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: isPartOfTeam
                      ? const Text(
                      AppStrings.alreadyPartOfTeam,
                    style: TextStyle(color: Colors.red)
                  )
                      : ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      String? result = Provider.of<PokemonTeamProvider>(context, listen: false)
                          .addPokemonToTeam(currentPokemon);
                      if (result != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(result)),
                        );
                      }
                    },
                    child: const Text(AppStrings.addToTeam),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
