class CocktailModel {
  final String id;
  final String name;
  final String image;
  final bool isAlcoholic;

  CocktailModel({
    required this.id,
    required this.name,
    required this.image,
    required this.isAlcoholic,
  });

  factory CocktailModel.fromJson(Map<String, dynamic> json) {
    return CocktailModel(
      id: json['idDrink'],
      name: json['strDrink'],
      image: json['strDrinkThumb'],
      isAlcoholic: json['strAlcoholic'] == 'Alcoholic',
    );
  }
}


