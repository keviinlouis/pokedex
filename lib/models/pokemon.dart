/*
Auto generated code by https://github.com/javiercbk/json_to_dart
this project cloned to https://gitee.com/yeganaaa/Json2Dart-Generator by yeganaaa@163.com
Thank you https://github.com/javiercbk/json_to_dart
*/

Map pokemonType = {
  'normal': 0xffa8a878,
  'grass': 0xff78c850,
  'ground': 0xffe0c068,
  'fighting': 0xffc03028,
  'rock': 0xffb8a038,
  'steel': 0xffb8b8d0,
  'fire': 0xfff08030,
  'electric': 0xfff8d030,
  'flying': 0xffa890f0,
  'psychic': 0xfff85888,
  'bug': 0xffa8b820,
  'dragon': 0xff7038f8,
  'water': 0xff6890f0,
  'ice': 0xff98d8d8,
  'poison': 0xffa040a0,
  'dark': 0xff705848,
  'ghost': 0xff705898,
  'fairy': 0xffffaec9,
};

class PokemonModel {
  int id;
  String name;
  int height;
  int weight;
  Sprites sprites;
  List<Stats> stats;
  List<Type> types;

  PokemonModel({
    this.id,
    this.name,
    this.height,
    this.weight,
    this.sprites,
    this.stats,
    this.types,
  });

  PokemonModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    height = json['height'];
    weight = json['weight'];

    sprites = Sprites.fromJson(json['sprites']);

    if (json['stats'] != null) {
      stats = new List<Stats>();
      json['stats'].forEach((v) {
        stats.add(new Stats.fromJson(v));
      });
    }
    if (json['types'] != null) {
      types = new List<Type>();
      json['types'].forEach((v) {
        types.add(Type.fromName(v['type']['name']));
      });
    }
  }
}

class Sprites {
  String backFemale;
  String backShinyFemale;
  String backDefault;
  String frontFemale;
  String frontShinyFemale;
  String backShiny;
  String frontDefault;
  String frontShiny;

  Sprites({
    this.backFemale,
    this.backShinyFemale,
    this.backDefault,
    this.frontFemale,
    this.frontShinyFemale,
    this.backShiny,
    this.frontDefault,
    this.frontShiny,
  });

  Sprites.fromJson(Map<String, dynamic> json) {
    backFemale = json['back_female'];
    backShinyFemale = json['back_shiny_female'];
    backDefault = json['back_default'];
    frontFemale = json['front_female'];
    frontShinyFemale = json['front_shiny_female'];
    backShiny = json['back_shiny'];
    frontDefault = json['front_default'];
    frontShiny = json['front_shiny'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['back_female'] = this.backFemale;
    data['back_shiny_female'] = this.backShinyFemale;
    data['back_default'] = this.backDefault;
    data['front_female'] = this.frontFemale;
    data['front_shiny_female'] = this.frontShinyFemale;
    data['back_shiny'] = this.backShiny;
    data['front_default'] = this.frontDefault;
    data['front_shiny'] = this.frontShiny;
    return data;
  }
}

class Stats {
  int value;
  String name;

  Stats({
    this.name,
    this.value,
  });

  Stats.fromJson(Map<String, dynamic> json) {
    name = json['stat']['name'].replaceAll('-', '\n');
    value = json['base_stat'];
  }
}

class Type {
  String name;
  int color;

  Type.fromName(String name) {
    this.name = name;
    this.color = pokemonType[name];
  }
}
