import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon_list_item.dart';
import 'package:pokedex/pokemon_colors.dart';
import 'package:pokedex/services/pokeapi.dart';
import 'package:pokedex/v2/views/pokemon_view/pokemon_view.dart';

class PokemonListItemView extends StatefulWidget {
  final PokemonListItem pokemonListItem;

  const PokemonListItemView({Key key, this.pokemonListItem}) : super(key: key);

  @override
  _PokemonListItemViewState createState() => _PokemonListItemViewState();
}

class _PokemonListItemViewState extends State<PokemonListItemView> {
  PokeApi api = PokeApi();

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool loading) {
    _loading = loading;
    setState(() {});
  }

  goToPokemonView(BuildContext context) async {
    loading = true;

    var pokemon = await api.fetchPokemon(widget.pokemonListItem.id);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PokemonView(
          pokemon: pokemon,
        ),
      ),
    );
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Hero(
        tag: widget.pokemonListItem.name,
        child: Image.network(widget.pokemonListItem.image),
      ),
      title: Text(widget.pokemonListItem.name),
      trailing: IconButton(
        onPressed: () => goToPokemonView(context),
        icon: loading
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(DefaultColors.red),
              )
            : Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
