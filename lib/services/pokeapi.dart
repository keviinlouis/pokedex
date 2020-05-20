import 'package:dio/dio.dart';
import 'package:pokedex/models/Pokemon.dart';

class PokeApi {
  static const BASE_URL = 'https://pokeapi.co/api/v2';

  Dio client;

  PokeApi() {
    client = Dio(BaseOptions(baseUrl: BASE_URL));
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
