import 'dart:convert';

class MakeFood {
  final String item;
  final List<String> ingredients;
  final List<String> procedure;

  MakeFood({
    required this.item,
    required this.ingredients,
    required this.procedure,
  });

  MakeFood copyWith({
    String? item,
    List<String>? ingredients,
    List<String>? procedure,
  }) =>
      MakeFood(
        item: item ?? this.item,
        ingredients: ingredients ?? this.ingredients,
        procedure: procedure ?? this.procedure,
      );

  factory MakeFood.fromRawJson(String str) =>
      MakeFood.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MakeFood.fromJson(Map<String, dynamic> json) => MakeFood(
        item: json["item"],
        ingredients: List<String>.from(json["ingredients"].map((x) => x)),
        procedure: List<String>.from(json["procedure"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "item": item,
        "ingredients": List<dynamic>.from(ingredients.map((x) => x)),
        "procedure": List<dynamic>.from(procedure.map((x) => x)),
      };
}
