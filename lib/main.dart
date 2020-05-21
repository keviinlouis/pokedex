import 'package:flutter/material.dart';
import 'package:pokedex/pokemon_colors.dart';
import 'package:pokedex/v2/views/list_view/pokemons_list_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: DefaultColors.red,
        accentColor: DefaultColors.white,
      ),
      home: PokemonsListView(),
    );
  }
}
