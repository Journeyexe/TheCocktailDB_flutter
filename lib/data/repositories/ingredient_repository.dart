
import 'dart:convert';

import 'package:thecocktaildb_app/data/http/http_client.dart';
import 'package:thecocktaildb_app/data/models/ingredient_model.dart';

abstract class IIngredientRepository {
  Future<List<IngredientModel>> getIngredient(String name);
}

class IngredientRepository implements IIngredientRepository {
  final IHttpClient client;

  IngredientRepository({
    required this.client,
  });

  @override
  Future<List<IngredientModel>> getIngredient(id) async {
    final List<IngredientModel> ingredient = [];
    final response = await client.get(
        url: 'https://www.thecocktaildb.com/api/json/v1/1/search.php?i=$id');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      for (final item in data['ingredients']) {
        ingredient.add(IngredientModel.fromJson(item));
      }
      return ingredient;
    } else {
      throw Exception('Failed to load details');
    }
  }
}