// To parse this JSON data, do
//
//     final episodeModel = episodeModelFromJson(jsonString);

import 'dart:convert';

EpisodeModel episodeModelFromJson(String str) => EpisodeModel.fromJson(json.decode(str));

String episodeModelToJson(EpisodeModel data) => json.encode(data.toJson());

class EpisodeModel {
  Data? data;

  EpisodeModel({
    this.data,
  });

  factory EpisodeModel.fromJson(Map<String, dynamic> json) => EpisodeModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Data {
  Episodes? episodes;

  Data({
    this.episodes,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    episodes: json["episodes"] == null ? null : Episodes.fromJson(json["episodes"]),
  );

  Map<String, dynamic> toJson() => {
    "episodes": episodes?.toJson(),
  };
}

class Episodes {
  List<Result>? results;

  Episodes({
    this.results,
  });

  factory Episodes.fromJson(Map<String, dynamic> json) => Episodes(
    results: json["results"] == null ? [] : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
  };
}

class Result {
  String? name;
  String? episode;
  String? id;

  Result({
    this.name,
    this.episode,
    this.id,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    name: json["name"],
    episode: json["episode"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "episode": episode,
    "id": id,
  };
}
