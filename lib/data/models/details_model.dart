class DetailsModel {
  final String name;
  late String category;
  late String description;
  final String image;
  final bool isAlcoholic;
  final List<IngredientsModel> ingredients;

  DetailsModel({
    required this.name,
    required this.category,
    required this.description,
    required this.image,
    required this.isAlcoholic,
    required this.ingredients,
  });

  factory DetailsModel.fromJson(Map<String, dynamic> json) {
    return DetailsModel(
      name: json['strDrink'],
      category: json['strCategory'],
      description: json['strInstructions'],
      image: json['strDrinkThumb'],
      isAlcoholic: json['strAlcoholic'] == 'Alcoholic',
      ingredients: List.generate(15, (index) {
        try {
          return IngredientsModel.fromJson(json, index);
        } catch (e) {
          return null;
        }
      }).where((element) => element != null).cast<IngredientsModel>().toList(),
    );
  }
}

class IngredientsModel {
  final String name;
  final String measure;

  IngredientsModel({
    required this.name,
    required this.measure,
  });

  factory IngredientsModel.fromJson(Map<String, dynamic> json, int index) {
    final ingredient = json['strIngredient${index + 1}'];
    final measure = json['strMeasure${index + 1}'] ?? '';

    if (ingredient.isEmpty) {
      throw Exception('Ingredient cannot be empty');
    }

    return IngredientsModel(
      name: ingredient,
      measure: measure,
    );
  }
}