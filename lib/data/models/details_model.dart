class DetailsModel {
  final String name;
  final String description;
  final String image;
  final List<IngredientModel> ingredients;

  DetailsModel({
    required this.name,
    required this.description,
    required this.image,
    required this.ingredients,
  });

  factory DetailsModel.fromJson(Map<String, dynamic> json) {
    return DetailsModel(
      name: json['strDrink'],
      description: json['strInstructions'],
      image: json['strDrinkThumb'],
      ingredients: List.generate(15, (index) {
        try {
          return IngredientModel.fromJson(json, index);
        } catch (e) {
          return null;
        }
      }).where((element) => element != null).cast<IngredientModel>().toList(),
    );
  }
}

class IngredientModel {
  final String name;
  final String measure;

  IngredientModel({
    required this.name,
    required this.measure,
  });

  factory IngredientModel.fromJson(Map<String, dynamic> json, int index) {
    final ingredient = json['strIngredient${index + 1}'];
    final measure = json['strMeasure${index + 1}'];

    if (ingredient.isEmpty) {
      throw Exception('Ingredient cannot be empty');
    }

    return IngredientModel(
      name: ingredient,
      measure: measure,
    );
  }
}
