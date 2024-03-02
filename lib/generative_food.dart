import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:make_food/make_food.dart';

const String geminiApiKey = 'GEMINI_API_KEY';

enum GenerativeModelType {
  geminiPro(name: 'gemini-pro'),
  geminiProVision(name: 'gemini-pro-vision');

  final String name;

  const GenerativeModelType({required this.name});
}

class GenerativeFood {
  GenerativeFood({
    GenerativeModelType type = GenerativeModelType.geminiPro,
  })  : assert(
          const bool.hasEnvironment(geminiApiKey),
          'Api Key is not Found',
        ),
        assert(
          const String.fromEnvironment(geminiApiKey).isNotEmpty,
          'Api Key is not Set',
        ),
        _model = GenerativeModel(
          model: type.name,
          apiKey: const String.fromEnvironment(geminiApiKey),
        );

  final GenerativeModel _model;

  /// foodType - something around indian/continental
  /// food - breakfast, lunch, or something
  Future<MakeFood?> makeFood(String foodType, String food,
      {bool isVegetarian = false}) async {
    final vegetarianString = isVegetarian ? '(vegetarian)' : '';
    final prompt =
        'Give me a recipe of a random $foodType food : $food $vegetarianString step by step instruction.'
        'Give only one item.'
        'Give the result in json with the scheme: {item: "", ingredients: ["", "", ...], procedure: ["", "", ...]}.'
        'Do not give the result in Markdown.';

    final response = await _model.generateContent([Content.text(prompt)]);
    String text =
        response.text!.replaceAll('```json', '').replaceAll('```', '');

    return MakeFood.fromRawJson(text);
  }
}
