// To parse this JSON data, do
//
//     final characterModel = characterModelFromJson(jsonString);

import 'dart:convert';

CharacterModel characterModelFromJson(String str) => CharacterModel.fromJson(json.decode(str));

String characterModelToJson(CharacterModel data) => json.encode(data.toJson());

class CharacterModel {
  Data? data;

  CharacterModel({
    this.data,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) => CharacterModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Data {
  Characters? characters;

  Data({
    this.characters,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    characters: json["characters"] == null ? null : Characters.fromJson(json["characters"]),
  );

  Map<String, dynamic> toJson() => {
    "characters": characters?.toJson(),
  };
}

class Characters {
  List<Result>? results;

  Characters({
    this.results,
  });

  factory Characters.fromJson(Map<String, dynamic> json) => Characters(
    results: json["results"] == null ? [] : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
  };
}

class Result {
  String? id;
  String? name;
  String? image;
  String? status;
  String? species;
  String? type;
  String? gender;

  Result({
    this.id,
    this.name,
    this.image,
    this.status,
    this.species,
    this.type,
    this.gender,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    status: json["status"]!,
    species: json["species"]!,
    type: json["type"],
    gender: json["gender"]!,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "status":status,
    "species": species,
    "type": type,
    "gender": gender,
  };
}

