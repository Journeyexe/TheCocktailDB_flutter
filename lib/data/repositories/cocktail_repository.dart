import 'dart:convert';

import 'package:thecocktaildb_app/data/http/http_client.dart';
import 'package:thecocktaildb_app/data/models/cocktail_model.dart';

abstract class ICocktailRepository {
  Future<List<CocktailModel>> getCocktails(String keyWord, bool searchByName);
}

class CocktailRepository implements ICocktailRepository {
  final IHttpClient client;

  CocktailRepository({
    required this.client,
  });

  @override
  Future<List<CocktailModel>> getCocktails(
      String keyWord, bool searchByName) async {
    final url = searchByName
        ? 'https://www.thecocktaildb.com/api/json/v1/1/search.php?s=${Uri.encodeComponent(keyWord)}'
        : 'https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=${Uri.encodeComponent(keyWord)}';

    final response = await client.get(url: url);

    try {
      final data = jsonDecode(response.body);
      final drinks = data['drinks'];

      if (drinks is String) {
        throw Exception('Nenhum drink encontrado!');
      }

        return (drinks as List)
            .map((drink) => CocktailModel.fromJson(drink))
            .toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}