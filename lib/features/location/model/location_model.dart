// To parse this JSON data, do
//
//     final locationModel = locationModelFromJson(jsonString);

import 'dart:convert';

LocationModel locationModelFromJson(String str) => LocationModel.fromJson(json.decode(str));

String locationModelToJson(LocationModel data) => json.encode(data.toJson());

class LocationModel {
  Data? data;

  LocationModel({
    this.data,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Data {
  Locations? locations;

  Data({
    this.locations,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    locations: json["locations"] == null ? null : Locations.fromJson(json["locations"]),
  );

  Map<String, dynamic> toJson() => {
    "locations": locations?.toJson(),
  };
}

class Locations {
  List<Result>? results;

  Locations({
    this.results,
  });

  factory Locations.fromJson(Map<String, dynamic> json) => Locations(
    results: json["results"] == null ? [] : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
  };
}

class Result {
  String? id;
  String? name;
  String? type;

  Result({
    this.id,
    this.name,
    this.type,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
  };
}
