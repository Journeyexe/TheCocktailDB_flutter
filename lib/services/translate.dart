import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:thecocktaildb_app/data/models/environment.dart';
import 'package:thecocktaildb_app/data/models/translation_model.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:translator/translator.dart';

Future<TranslationModel> translateAPI(String text) async {
  await dotenv.load(fileName: Environment.fileName);
  var apiKey = Environment.apiKey;

  final url = Uri.parse(
    'https://translation.googleapis.com/language/translate/v2?key=$apiKey&q=$text&source=en&target=pt',
  );

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final body = jsonDecode(response.body);
    final translatedText = body['data']['translations'][0]['translatedText'];

    // Decodificar entidades HTML
    final unescape = HtmlUnescape();
    final decodedText = unescape.convert(translatedText);

    return TranslationModel(
      text: decodedText,
    );
  } else {
    throw Exception('Failed to translate text');
  }
}

Future<TranslationModel> translate(String text) async {
  final translator = GoogleTranslator();
  final translation = await translator.translate(text, to: 'pt');
  return TranslationModel(text: translation.text);
}
