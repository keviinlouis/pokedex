import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pokedex/models/Pokemon.dart';
import 'package:pokedex/services/pokeapi.dart';

import 'pokemon_content.dart';

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  PokemonModel pokemon;
  Timer _debounce;

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool loading) {
    _loading = loading;
    setState(() {});
  }

  bool error = false;

  PokeApi api = PokeApi();

  search(String value) async {
    if (value == null || value.isEmpty) return;

    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      loading = true;

      print("Procurando Pokemons $value");
      pokemon = await api.fetchPokemon(value);

      error = pokemon == null;

      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        brightness: Brightness.light,
        centerTitle: false,
        title: Text(
          'Pokédex',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) => search(value),
              decoration: InputDecoration(
                hintText: 'Search',
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.red, width: 5),
                ),
              ),
            ),
          ),
          Expanded(
            child: _buildList(),
          )
        ],
      ),
    );
  }

  _buildList() {
    if (loading) return Center(child: CircularProgressIndicator());

    if (error)
      return Center(
        child: Text('Não encontramos este pokemon'),
      );

    if (pokemon == null) {
      return Center(
        child: Text('Hora de procurar um pokemon'),
      );
    }

    return _buildItem(pokemon);
  }

  _buildItem(PokemonModel pokemon) {
    return PokemonContent(
      pokemonModel: pokemon,
    );
  }
}
