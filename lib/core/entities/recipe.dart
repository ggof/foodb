import 'ingredient.dart';
import 'model.dart';
import 'step.dart';

class Recipe extends Model {
  var name = "";
  var description = "";
  var image = "";
  var calories = 0;
  var proteins = 0;
  var servings = 0;
  final List<Ingredient> ingredients;
  final List<Step> steps;

  Recipe(
    String id,
    this.image,
    this.name,
    this.description,
    this.proteins,
    this.calories,
    this.servings, {
    this.ingredients = const [],
    this.steps = const [],
  }) : super(id);

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        json["id"],
        json["image"],
        json["name"],
        json["description"],
        json["proteins"],
        json["calories"],
        json["servings"],
        ingredients: json["ingredients"]
            .map<Ingredient>((i) => Ingredient.fromJSON(i))
            .toList(),
        steps: json["steps"].map<Step>((i) => Step.fromJSON(i)).toList(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "description": description,
        "proteins": proteins,
        "calories": calories,
        "servings": servings,
        "ingredients": ingredients.map((i) => i.toJSON()).toList(),
        "steps": steps.map((i) => i.toJSON()).toList(),
      };

  Recipe copyWith({
    String? id,
    String? image,
    String? name,
    String? description,
    int? proteins,
    int? calories,
    int? servings,
    List<Ingredient>? ingredients,
    List<Step>? steps,
  }) =>
      Recipe(
        id ?? this.id,
        image ?? this.image,
        name ?? this.name,
        description ?? this.description,
        proteins ?? this.proteins,
        calories ?? this.calories,
        servings ?? this.servings,
        ingredients: ingredients ?? this.ingredients,
        steps: steps ?? this.steps,
      );
}
