import 'package:dio/dio.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/models/pokemon_list_item.dart';

class PokeApi {
  static const BASE_URL = 'https://pokeapi.co/api/v2';
  static const BASE_IMAGE_URL =
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon';

  Dio client;

  PokeApi() {
    client = Dio(BaseOptions(baseUrl: BASE_URL));
  }

  Future<List<PokemonListItem>> fetchPokemons(
      {int page = 1, String query}) async {
    if (query != null) {}

    if (page < 1) page = 1;

    int limit = 20;
    int offset = page * limit;

    String url = '/pokemon?limit=$limit&offset=$offset';
    try {
      Response response = await client.get(url);
      List data = response.data['results'];
      return data.map((pokemon) => PokemonListItem.fromJson(pokemon)).toList();
    } on DioError catch (error) {
      if (error.type == DioErrorType.RESPONSE &&
          error.response.statusCode == 404) {
        return null;
      }

      throw error;
    }
  }

  Future<PokemonListItem> fetchPokemonAsPokemonListItem(String value) async {
    var pokemon = await fetchPokemon(value);

    if (pokemon == null) return null;

    var name = pokemon.name;
    var url = pokemon.id.toString();

    return PokemonListItem(name: name, url: url);
  }

  Future<PokemonModel> fetchPokemon(String name) async {
    String url = '/pokemon/$name';
    try {
      Response response = await client.get(url);

      return PokemonModel.fromJson(response.data);
    } on DioError catch (error) {
      if (error.type == DioErrorType.RESPONSE &&
          error.response.statusCode == 404) {
        return null;
      }

      throw error;
    }
  }
}
