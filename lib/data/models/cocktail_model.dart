class CocktailModel {
  final String id;
  final String name;
  final String image;

  CocktailModel({
    required this.name,
    required this.image,
    required this.id,
  });

  factory CocktailModel.fromJson(Map<String, dynamic> json) {
    return CocktailModel(
      name: json['strDrink'],
      image: json['strDrinkThumb'],
      id: json['idDrink'],
    );
  }
}


