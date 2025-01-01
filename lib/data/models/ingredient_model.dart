class IngredientModel {
  final String name;
  late String translatedName;
  late String description;
  late String type;
  final bool isAlcoholic;

  IngredientModel({
    required this.name,
    required this.description,
    required this.type,
    required this.isAlcoholic,
  });

  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    return IngredientModel(
      name: json['strIngredient'],
      description: json['strDescription'] ?? 'null',
      type: json['strType'] ?? 'null',
      isAlcoholic: (json['strAlcohol'] == 'Yes'),
    );
  }
}
