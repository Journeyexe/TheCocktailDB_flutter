import 'dart:convert';

import 'package:thecocktaildb_app/data/http/http_client.dart';
import 'package:thecocktaildb_app/data/models/cocktail_model.dart';

abstract class ICocktailRepository {
  Future<List<CocktailModel>> getCocktails(String name);
}

class CocktailRepository implements ICocktailRepository {
  final IHttpClient client;

  CocktailRepository({
    required this.client,
  });

  @override
  Future<List<CocktailModel>> getCocktails(name) async {
    final List<CocktailModel> cocktails = [];
    final response = await client.get(
        // url: 'https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=$name');
        url: 'https://www.thecocktaildb.com/api/json/v1/1/search.php?s=$name');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      for (final item in data['drinks']) {
        cocktails.add(CocktailModel.fromJson(item));
      }
      return cocktails;
    } else {
      throw Exception('Failed to load cocktails');
    }
  }
}
