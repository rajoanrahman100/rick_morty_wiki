// To parse this JSON data, do
//
//     final castDetailsModel = castDetailsModelFromJson(jsonString);

import 'dart:convert';

CastDetailsModel castDetailsModelFromJson(String str) => CastDetailsModel.fromJson(json.decode(str));

String castDetailsModelToJson(CastDetailsModel data) => json.encode(data.toJson());

class CastDetailsModel {
  Data? data;

  CastDetailsModel({
    this.data,
  });

  factory CastDetailsModel.fromJson(Map<String, dynamic> json) => CastDetailsModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Data {
  Character? character;

  Data({
    this.character,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    character: json["character"] == null ? null : Character.fromJson(json["character"]),
  );

  Map<String, dynamic> toJson() => {
    "character": character?.toJson(),
  };
}

class Character {
  String? id;
  String? name;
  String? image;
  String? status;
  String? species;
  String? gender;
  Location? location;
  Origin? origin;
  List<Episode>? episode;

  Character({
    this.id,
    this.name,
    this.image,
    this.status,
    this.species,
    this.gender,
    this.location,
    this.origin,
    this.episode,
  });

  factory Character.fromJson(Map<String, dynamic> json) => Character(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    status: json["status"],
    species: json["species"],
    gender: json["gender"],
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    origin: json["origin"] == null ? null : Origin.fromJson(json["origin"]),
    episode: json["episode"] == null ? [] : List<Episode>.from(json["episode"]!.map((x) => Episode.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "status": status,
    "species": species,
    "gender": gender,
    "location": location?.toJson(),
    "origin": origin?.toJson(),
    "episode": episode == null ? [] : List<dynamic>.from(episode!.map((x) => x.toJson())),
  };
}

class Location {
  String? name;

  Location({
    this.name,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };


}

class Origin {
  String? name;

  Origin({
    this.name,
  });

  factory Origin.fromJson(Map<String, dynamic> json) => Origin(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };


}

class Episode {
  String? name;

  Episode({
    this.name,
  });

  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };


}
