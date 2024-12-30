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

      if (drinks is String || drinks == null) {
        throw Exception('Nenhum drink encontrado!');
      }

      if (searchByName) {
        return (drinks as List)
            .map((drink) => CocktailModel.fromJson(drink))
            .toList();
      }

      // Limitar o número de requisições simultâneas
      const int maxConcurrentRequests = 10; // Limite de requisições simultâneas
      final cocktails = await _fetchDetailsWithLimit(
        drinks.cast<Map<String, dynamic>>(),
        maxConcurrentRequests,
      );

      return cocktails;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<CocktailModel>> _fetchDetailsWithLimit(
      List<Map<String, dynamic>> drinks, int maxConcurrentRequests) async {
    final List<CocktailModel> cocktails = [];
    final List<Future<void>> ongoingTasks = [];

    for (final drink in drinks) {
      if (ongoingTasks.length >= maxConcurrentRequests) {
        await Future.any(ongoingTasks);
      }

      final task = _fetchDrinkDetail(drink).then((cocktail) {
        if (cocktail != null) cocktails.add(cocktail);
      }).catchError((_) {
        // Ignorar erros individuais, mas você pode tratar isso se necessário
      });

      ongoingTasks.add(task);

      // Esperar todas as tarefas serem concluídas
      await Future.wait(ongoingTasks);
      ongoingTasks.clear();
    }

    // Esperar todas as tarefas restantes serem concluídas
    await Future.wait(ongoingTasks);

    return cocktails;
  }

  Future<CocktailModel?> _fetchDrinkDetail(Map<String, dynamic> drink) async {
    try {
      final drinkResponse = await client.get(
        url:
            'https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=${drink['idDrink']}',
      );

      if (drinkResponse.statusCode == 200) {
        final drinkData = jsonDecode(drinkResponse.body);
        final drinkDetails = drinkData['drinks']?.first;

        if (drinkDetails != null) {
          return CocktailModel.fromJson(drinkDetails);
        }
      }
    } catch (e) {
      // Log ou tratamento de erro
    }
    return null; // Retornar null em caso de erro
  }
}
