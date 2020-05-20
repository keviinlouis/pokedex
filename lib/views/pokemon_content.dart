import 'package:flutter/material.dart';
import 'package:pokedex/models/Pokemon.dart';

import '../pokemon_colors.dart';

class PokemonContent extends StatefulWidget {
  final PokemonModel pokemonModel;

  PokemonContent({Key key, this.pokemonModel}) : super(key: key);

  @override
  _PokemonContentState createState() => _PokemonContentState();
}

class _PokemonContentState extends State<PokemonContent> {
  PokemonModel get pokemon => widget.pokemonModel;

  Color get color => pokemonType[widget.pokemonModel.types.first.type.name];

  bool _shiny = false;

  bool get shiny => _shiny;

  set shiny(bool shiny) {
    _shiny = shiny;
    setState(() {});
  }

  bool _backImg = false;

  bool get backImg => _backImg;

  set backImg(bool backImg) {
    _backImg = backImg;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: _buildInfo(),
        ),
        _buildControls(),
        Expanded(
          child: _buildAllStats(),
        ),
      ],
    );
  }

  _buildInfo() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              _buildTitle(),
              _buildImage(),
              _buildTypes(),
            ],
          ),
        ),
      ),
    );
  }

  _buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "${pokemon.name.toUpperCase()} #${pokemon.id}",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        Text(
          "WEIGHT: ${pokemon.weight.toString()} HEIGHT: ${pokemon.height.toString()}",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ],
    );
  }

  _buildImage() {
    String image =
        backImg ? pokemon.sprites.backDefault : pokemon.sprites.frontDefault;

    if (shiny) {
      image = backImg ? pokemon.sprites.backShiny : pokemon.sprites.frontShiny;
    }

    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(image),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  _buildTypes() {
    return Container(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: pokemon.types.length,
        itemBuilder: (context, index) {
          Types type = pokemon.types[index];
          return Card(
            color: pokemonType[type.type.name],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                type.type.name.toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }

  _buildControls() {
    return Container(
      color: Color(0xFF201d1d),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            onPressed: () => backImg = !backImg,
            icon: Icon(Icons.arrow_back),
            color: Color(0xFFf7f7f7),
          ),
          RaisedButton(
            onPressed: () => shiny = false,
            child: Text(
              'DEFAULT',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            color: Color(0xFFf7f7f7),
            textColor: Color(0xFF201d1d),
          ),
          RaisedButton(
            onPressed: () => shiny = true,
            child: Text(
              'SHINY',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            color: Color(0xFFf7f7f7),
            textColor: Color(0xFF201d1d),
          ),
          IconButton(
            onPressed: () => backImg = !backImg,
            icon: Icon(Icons.arrow_forward),
            color: Color(0xFFf7f7f7),
          )
        ],
      ),
    );
  }

  _buildAllStats() {
    return Container(
      color: Colors.red,
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        childAspectRatio: 16 / 9,
        children: pokemon.stats.map(_buildStats).toList(),
      ),
    );
  }

  Widget _buildStats(Stats stats) {
    TextStyle style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );

    var name = stats.stat.name;

    name = name.replaceAll('-', '\n');

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Flexible(
            child: Center(
              child: Text(
                name.toUpperCase(),
                style: style,
              ),
            ),
          ),
          Center(
            child: Text(
              stats.baseStat.toString(),
              style: style,
            ),
          )
        ],
      ),
    );
  }
}
