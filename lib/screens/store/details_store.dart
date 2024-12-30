import 'package:flutter/material.dart';
import 'package:thecocktaildb_app/data/http/exceptions.dart';
import 'package:thecocktaildb_app/data/models/details_model.dart';
import 'package:thecocktaildb_app/data/repositories/details_repository.dart';
import 'package:thecocktaildb_app/services/translate.dart';

class DetailsStore {
  final IDetailsRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<DetailsModel>> state =
      ValueNotifier<List<DetailsModel>>([]);

  final ValueNotifier<String> erro = ValueNotifier<String>('');

  DetailsStore({required this.repository});

  Future getDetails(String id) async {
    isLoading.value = true;

    try {
      final result = await repository.getDetails(id);
      try {
        final translatedDescription = await translateAPI(result[0].description);
        result[0].description = translatedDescription.text;
        if (!['Shake', 'Shot'].contains(result[0].category)) {
          final translatedCategory = await translateAPI(result[0].category);
          result[0].category = translatedCategory.text;
        }
      } catch (e) {
        final translatedDescription = await translate(result[0].description);
        result[0].description = translatedDescription.text;
        if (!['Shake', 'Shot'].contains(result[0].category)) {
          final translatedCategory = await translate(result[0].category);
          result[0].category = translatedCategory.text;
        }
      }
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
