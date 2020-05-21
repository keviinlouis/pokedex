import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/v2/views/pokemon_view/pokemon_image_controllers.dart';

class PokemonView extends StatefulWidget {
  final PokemonModel pokemon;

  PokemonView({Key key, this.pokemon}) : super(key: key);

  @override
  _PokemonViewState createState() => _PokemonViewState();
}

class _PokemonViewState extends State<PokemonView> {
  PokemonModel get pokemon => widget.pokemon;

  String _image;

  String get image => _image;

  set image(String image) {
    _image = image;
    setState(() {});
  }

  updateImage(bool shiny, bool back) {
    Sprites sprites = pokemon.sprites;
    if (shiny) {
      image = back ? sprites.backShiny : sprites.frontShiny;
      return;
    }

    image = back ? sprites.backDefault : sprites.frontDefault;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "${pokemon.name.toUpperCase()} #${pokemon.id}",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: _buildInfo(),
          ),
          _buildControls(),
          Expanded(
            child: _buildAllStats(),
          ),
        ],
      ),
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
              Expanded(
                child: _buildImage(),
              ),
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
          "HEIGHT: ${pokemon.height.toString()}",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        Text(
          "WEIGHT: ${pokemon.weight.toString()}",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ],
    );
  }

  _buildImage() {
    if (image == null) {
      image = pokemon.sprites.frontDefault;
    }

    return Hero(
      tag: pokemon.name,
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(image),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  _buildTypes() {
    return Container(
      child: Row(
        children: pokemon.types.map(_buildType).toList(),
      ),
    );
  }

  Widget _buildType(Type type) {
    return Card(
      color: Color(type.color),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          type.name.toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  _buildControls() {
    return PokemonImageControllers(
      onImageChanged: updateImage,
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

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Flexible(
            child: Center(
              child: Text(
                stats.name.toUpperCase(),
                style: style,
              ),
            ),
          ),
          Center(
            child: Text(
              stats.value.toString(),
              style: style,
            ),
          )
        ],
      ),
    );
  }
}
