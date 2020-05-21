import 'package:flutter/material.dart';

class PokemonImageControllers extends StatefulWidget {
  final Function(bool shiny, bool back) onImageChanged;
  PokemonImageControllers({Key key, this.onImageChanged}) : super(key: key);

  @override
  _PokemonImageControllersState createState() =>
      _PokemonImageControllersState();
}

class _PokemonImageControllersState extends State<PokemonImageControllers> {
  bool _shiny = false;

  bool get shiny => _shiny;

  set shiny(bool shiny) {
    _shiny = shiny;
    widget.onImageChanged(shiny, backImg);
  }

  bool _backImg = false;

  bool get backImg => _backImg;

  set backImg(bool backImg) {
    _backImg = backImg;
    widget.onImageChanged(shiny, backImg);
  }

  @override
  Widget build(BuildContext context) {
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
}
