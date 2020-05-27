import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon_list_item.dart';
import 'package:pokedex/services/pokeapi.dart';

import '../pokemon_colors.dart';

class SearchPokemonView extends StatefulWidget {
  @override
  _SearchPokemonViewState createState() => _SearchPokemonViewState();
}

class _SearchPokemonViewState extends State<SearchPokemonView> {
  List<PokemonListItem> pokemons = [];
  bool error = false;
  bool loading = false;
  var api = PokeApi();

  onSearch(String value) async {
    if(value == null || value.isEmpty) return fetchPokemonsList();

    setState(() {
      loading = true;
    });

    var pokemon = await api.fetchPokemonAsPokemonListItem(value);

    if(pokemon == null) return setState(() {
      pokemons = [];
      error = true;
      loading = false;
    });

    setState(() {
      pokemons = [pokemon];
      loading = false;
    });
  }

  fetchPokemonsList() async {
    pokemons = await api.fetchPokemons();

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    fetchPokemonsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: DefaultColors.red,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Pokedex',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 32,
            color: DefaultColors.white,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: DefaultColors.red,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: onSearch,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: DefaultColors.white,
                  hintText: 'Search Pokemon',
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          Expanded(
            child: _buildList(),
          ),
        ],
      ),
    );
  }

  _buildList() {
    if(loading) return Center(child: CircularProgressIndicator(),);

    return ListView.builder(
      itemCount: pokemons.length,
      itemBuilder: (context, index) {
        PokemonListItem pokemon = pokemons[index];
        return _buildPokemonListItem(pokemon);
      },
    );
  }

  Widget _buildPokemonListItem(PokemonListItem pokemon) {
    return ListTile(
      leading: Image.network(pokemon.image),
      title: Text(pokemon.name),
      trailing: IconButton(
        onPressed: () => {},
        icon: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
