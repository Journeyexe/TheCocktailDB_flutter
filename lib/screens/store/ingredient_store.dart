import 'package:flutter/material.dart';
import 'package:thecocktaildb_app/data/models/ingredient_model.dart';
import 'package:thecocktaildb_app/data/repositories/ingredient_repository.dart';
import 'package:thecocktaildb_app/services/translate.dart';

class IngredientStore {
  final IIngredientRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<IngredientModel>> state =
      ValueNotifier<List<IngredientModel>>([]);

  final ValueNotifier<String> erro = ValueNotifier<String>('');

  IngredientStore({required this.repository});

  Future getIngredient(String id) async {
    isLoading.value = true;
    try {
      final result = await repository.getIngredient(id);
      try {
        final translatedTitle = await translateAPI(result[0].name);
        result[0].translatedName = translatedTitle.text;
        if (!['null'].contains(result[0].description)) {
          final translatedDescription =
              await translateAPI(result[0].description);
          result[0].description = translatedDescription.text;
        }
        if (!['null'].contains(result[0].type)) {
          final translatedCategory = await translateAPI(result[0].type);
          result[0].type = translatedCategory.text;
        }
      } catch (e) {
        final translatedTitle = await translate(result[0].name);
        result[0].translatedName = translatedTitle.text;
        if (!['null'].contains(result[0].description)) {
          final translatedDescription = await translate(result[0].description);
          result[0].description = translatedDescription.text;
        }
        if (!['null'].contains(result[0].type)) {
          final translatedCategory = await translate(result[0].type);
          result[0].type = translatedCategory.text;
        }
      }
      state.value = result;
      erro.value = '';
    } catch (e) {
      erro.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
