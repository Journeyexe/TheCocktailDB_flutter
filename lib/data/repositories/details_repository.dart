import 'dart:convert';

import 'package:thecocktaildb_app/data/http/http_client.dart';
import 'package:thecocktaildb_app/data/models/details_model.dart';

abstract class IDetailsRepository {
  Future<List<DetailsModel>> getDetails(String id, bool random);
}

class DetailsRepository implements IDetailsRepository {
  final IHttpClient client;

  DetailsRepository({
    required this.client,
  });

  @override
  Future<List<DetailsModel>> getDetails(id, random) async {
    final List<DetailsModel> details = [];
    final url = random
        ? 'https://www.thecocktaildb.com/api/json/v1/1/random.php'
        : 'https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=$id';
    final response = await client.get(
        url: url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      for (final item in data['drinks']) {
        details.add(DetailsModel.fromJson(item));
      }
      return details;
    } else {
      throw Exception('Failed to load details');
    }
  }
}
