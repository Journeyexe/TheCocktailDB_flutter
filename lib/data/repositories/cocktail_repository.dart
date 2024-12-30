import 'dart:convert';

import 'package:thecocktaildb_app/data/http/http_client.dart';
import 'package:thecocktaildb_app/data/models/cocktail_model.dart';

abstract class ICocktailRepository {
  Future<List<CocktailModel>> getCocktails(String name, bool searchByName);
}

class CocktailRepository implements ICocktailRepository {
  final IHttpClient client;

  CocktailRepository({
    required this.client,
  });

  @override
  Future<List<CocktailModel>> getCocktails(keyWord, searchByName) async {
    final List<CocktailModel> cocktails = [];
    String url;
    searchByName
        ? url =
            'https://www.thecocktaildb.com/api/json/v1/1/search.php?s=$keyWord'
        : url =
            'https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=$keyWord';
    try {
      final response = await client.get(url: url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        for (final item in data['drinks']) {
          cocktails.add(CocktailModel.fromJson(item));
        }
      }
    } catch (e) {
      throw 'Nenhum drink encontrado!';
    }
    return cocktails;
  }
}
