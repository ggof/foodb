import 'package:foodb/core/domain/entities/ingredient.dart';
import 'package:foodb/core/domain/entities/step.dart';

import 'model.dart';

class Recipe extends Model {
  var name = "";
  var description = "";
  var image = "";
  var calories = 0;
  var proteins = 0;
  var servings = 0;
  final List<Ingredient> ingredients;
  final List<Step> steps;

  Recipe({
    String id,
    this.image,
    this.name,
    this.description,
    this.proteins,
    this.calories,
    this.servings,
    this.ingredients = const [],
    this.steps = const [],
  }) : super(id: id);

  factory Recipe.fromJSON(Map<String, dynamic> json) => Recipe(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        proteins: json["proteins"],
        calories: json["calories"],
        servings: json["servings"],
        description: json["description"],
        ingredients: json["ingredients"].map((i) => Ingredient.fromJSON(i)),
        steps: json["steps"].map((i) => Step.fromJSON(i)),
      );

  Map<String, dynamic> toJSON() => {
        "id": id,
        "image": image,
        "name": name,
        "description": description,
        "proteins": proteins,
        "calories": calories,
        "servings": servings,
        "ingredients": ingredients.map((i) => i.toJSON()),
        "steps": steps.map((i) => i.toJSON()),
      };

  Recipe copyWith({
    String id,
    String image,
    String name,
    String description,
    int proteins,
    int calories,
    int servings,
    List<Ingredient> ingredients,
    List<Step> steps,
  }) =>
      Recipe(
        id: id ?? this.id,
        name: name ?? this.name,
        proteins: proteins ?? this.proteins,
        calories: calories ?? this.calories,
        servings: servings ?? this.servings,
        description: description ?? this.description,
        image: image ?? this.image,
        ingredients: ingredients ?? this.ingredients,
        steps: steps ?? this.steps,
      );
}
