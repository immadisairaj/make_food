import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:make_food/make_food.dart';

const String geminiApiKey = 'GEMINI_API_KEY';

enum GenerativeModelType {
  gemini1Dot0Pro(name: 'gemini-1.0-pro');
  // gemini1Dot5Pro(name: 'gemini-1.5-pro-latest'),
  // gemini1Dot0ProVision(name: 'gemini-1.0-pro-vision-latest');

  final String name;

  const GenerativeModelType({required this.name});
}

class GenerativeFood {
  GenerativeFood({
    GenerativeModelType type = GenerativeModelType.gemini1Dot0Pro,
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

  /// crusine - something around indian/continental
  /// food - breakfast, lunch, or something
  Future<MakeFood?> makeFood(String crusine, String food,
      {bool isVegetarian = false}) async {
    final vegetarianString =
        isVegetarian ? 'Only vegetarian Food (no non-veg, no egg).' : '';
    final prompt =
        'Give me a recipe of a random $crusine food : $food. $vegetarianString With step by step instruction.'
        'Give only one item.'
        'Give the result in json with the scheme: {item: "", ingredients: ["", "", ...], procedure: ["", "", ...]}.'
        'Do not give the result in Markdown.';

    final response = await _model.generateContent([Content.text(prompt)]);
    String text =
        response.text!.replaceAll('```json', '').replaceAll('```', '');

    return MakeFood.fromRawJson(text);
  }
}
