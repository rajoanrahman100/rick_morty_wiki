class FavouriteCharactersResult {
  String? id;
  String? name;
  String? image;

  FavouriteCharactersResult({
    this.id,
    this.name,
    this.image,
  });

  factory FavouriteCharactersResult.fromJson(Map<String, dynamic> json) => FavouriteCharactersResult(
        id: json["id"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
      };
}
