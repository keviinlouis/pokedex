import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon_list_item.dart';
import 'package:pokedex/pokemon_colors.dart';
import 'package:pokedex/services/pokeapi.dart';
import 'package:pokedex/v2/views/list_view/pokemon_list_item_view.dart';

class PokemonsListView extends StatefulWidget {
  @override
  _PokemonsListViewState createState() => _PokemonsListViewState();
}

class _PokemonsListViewState extends State<PokemonsListView> {
  List<PokemonListItem> pokemons = [];

  Timer _debounce;

  int page = 1;

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool loading) {
    _loading = loading;
    setState(() {});
  }

  bool notFound = false;

  PokeApi api = PokeApi();

  void search(String value) async {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (value.isEmpty) return fetchList();

      notFound = false;
      loading = true;

      PokemonListItem pokmemon = await api.fetchPokemonAsPokemonListItem(value);

      notFound = pokmemon == null;

      pokemons = [pokmemon].where((value) => value != null).toList();

      page = 1;

      await Future.delayed(Duration(seconds: 1), () => {});

      loading = false;
    });
  }

  Future<void> fetchList({int page = 1}) async {
    notFound = false;
    loading = true;

    var pokemons = await api.fetchPokemons(page: page);

    if (page == 1)
      this.pokemons = pokemons;
    else
      this.pokemons.addAll(pokemons);

    await Future.delayed(Duration(seconds: 1), () => {});

    loading = false;
  }

  @override
  void initState() {
    super.initState();

    fetchList();
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
                onChanged: search,
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
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: _buildList(),
                ),
                Container(
                  height: 15,
                  color: DefaultColors.black,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 30,
                      width: 30,
                      transform: Matrix4.translationValues(0, -5, 0),
                      decoration: BoxDecoration(
                        color: DefaultColors.white,
                        border:
                            Border.all(color: DefaultColors.black, width: 3),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildList() {
    if (notFound)
      return Center(
        child: Text('Não encontramos este pokemon'),
      );

    return RefreshIndicator(
      onRefresh: fetchList,
      color: DefaultColors.red,
      child: ListView(
        children: [
          ...pokemons.map(buildListItem).toList(),
          if (loading)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(DefaultColors.red),
                ),
              ),
            )
        ],
      ),
    );
  }

  Widget buildListItem(PokemonListItem pokemonListItem) {
    return PokemonListItemView(
      pokemonListItem: pokemonListItem,
    );
  }
}
