class TranslationModel {
  final String text;

  TranslationModel({
    required this.text,
  });

  factory TranslationModel.fromJson(Map<String, dynamic> json) {
    return TranslationModel(
      text: json['translatedText'],
    );
  }
}
