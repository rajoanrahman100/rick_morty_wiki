class FavouriteCharacterModel {
  String? id;
  String? name;
  String? image;
  String? status;
  String? species;
  String? type;
  String? gender;

  FavouriteCharacterModel({
    this.id,
    this.name,
    this.image,
    this.status,
    this.species,
    this.type,
    this.gender,
  });

  factory FavouriteCharacterModel.fromJson(Map<String, dynamic> json) => FavouriteCharacterModel(
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
        "status": status,
        "species": species,
        "type": type,
        "gender": gender,
      };
}
