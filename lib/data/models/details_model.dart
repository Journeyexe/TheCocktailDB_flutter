class DetailsModel {
  final String name;
  // final String description;
  // final String image;
  // final List<IngredientModel> ingredients;

  DetailsModel({
    required this.name,
    // required this.description,
    // required this.image,
    // required this.ingredients,
  });

  factory DetailsModel.fromJson(Map<String, dynamic> json) {
    return DetailsModel(
      name: json['strDrink'],
      // description: json['strInstructions'],
      // image: json['strDrinkThumb'],
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
      // }).where((element) => element != null).cast<IngredientModel>().toList(),
    );
  }
}

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
