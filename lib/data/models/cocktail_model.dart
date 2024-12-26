// class IngredientModel {
//   final String name;
//   final String measure;

//   IngredientModel({
//     required this.name,
//     required this.measure,
//   });

//   factory IngredientModel.fromJson(Map<String, dynamic> json) {
//     return IngredientModel(
//       name: json['strIngredient1'],
//       measure: json['strMeasure1'],
//     );
//   }
// }

class CocktailModel {
  final String name;
  final String image;
  // final String description;
  // final bool isAlcoholic;
  // final List<IngredientModel> ingredients;

  CocktailModel({
    required this.name,
    required this.image,
    // required this.description,
    // required this.isAlcoholic,
    // required this.ingredients,
  });

  factory CocktailModel.fromJson(Map<String, dynamic> json) {
    return CocktailModel(
      name: json['strDrink'],
      image: json['strDrinkThumb'],
      // description: json['strInstructions'],
      // isAlcoholic: (json['strAlcoholic'] == 'Alcoholic')? true : false,
      // ingredients: List.generate(15, (index) {
      //   final ingredient = json['strIngredient${index + 1}'];
      //   final measure = json['strMeasure${index + 1}'];

      //   if (ingredient == null || ingredient.isEmpty) {
      //     return null;
      //   }

      //   return IngredientModel(
      //     name: ingredient,
      //     measure: measure,
      //   );
      // }).where((element) => element != null)
      // .cast<IngredientModel>()
      // .toList(),     
    );
  }
}
