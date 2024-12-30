import 'package:flutter/material.dart';
import 'package:thecocktaildb_app/data/http/exceptions.dart';
import 'package:thecocktaildb_app/data/models/cocktail_model.dart';
import 'package:thecocktaildb_app/data/repositories/cocktail_repository.dart';

class CocktailStore {
  final ICocktailRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<CocktailModel>> state =
      ValueNotifier<List<CocktailModel>>([]);

  final ValueNotifier<String> erro = ValueNotifier<String>('');

  CocktailStore({required this.repository});

  Future getCocktails(String name, bool searchByName) async {
    isLoading.value = true;

    try {
      final result = await repository.getCocktails(name, searchByName);
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }

    isLoading.value = false;
  }
}
