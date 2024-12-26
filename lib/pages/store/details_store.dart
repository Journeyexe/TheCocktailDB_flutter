import 'package:flutter/material.dart';
import 'package:thecocktaildb_app/data/http/exceptions.dart';
import 'package:thecocktaildb_app/data/models/details_model.dart';
import 'package:thecocktaildb_app/data/repositories/details_repository.dart';

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
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }

    isLoading.value = false;
  }
}