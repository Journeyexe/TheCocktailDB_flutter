import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';

Future<List<Map<String, dynamic>>> loadIngredientsJson() async {
  final String jsonString =
      await rootBundle.loadString('assets/ingredients.json');
  final Map<String, dynamic> jsonData = jsonDecode(jsonString);

  return List<Map<String, dynamic>>.from(jsonData['ingredients']);
}

Future<List<Map<String, dynamic>>> loadRandomIngredients() async {
  final rng = Random();

  final String jsonString =
      await rootBundle.loadString('assets/ingredients.json');
  final Map<String, dynamic> jsonData = jsonDecode(jsonString);

  final ingredients = List<Map<String, dynamic>>.from(jsonData['ingredients']);

  ingredients.shuffle(rng);
  return ingredients.take(3).toList();
}
