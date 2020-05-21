import 'package:pokedex/services/pokeapi.dart';

class PokemonListItem {
  String name;
  String url;

  PokemonListItem({this.name, this.url});

  PokemonListItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  String get id => url.split('/').where((value) => value != "").last;

  String get image => '${PokeApi.BASE_IMAGE_URL}/$id.png';
}
