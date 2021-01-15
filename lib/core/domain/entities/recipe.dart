import 'package:foodb/core/domain/entities/ingredient.dart';
import 'package:foodb/core/domain/entities/step.dart';

import 'model.dart';

class Recipe extends Model {
  var name = "";
  var description = "";
  var ingredients = <Ingredient>[];
  var steps = <Step>[];

  Recipe({String id, this.name, this.description, this.ingredients, this.steps})
      : super(id: id);

  factory Recipe.fromJSON(Map<String, dynamic> json) => Recipe(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        ingredients: json["ingredients"].map((i) => Ingredient.fromJSON(i)),
        steps: json["steps"].map((i) => Step.fromJSON(i)),
      );

  Map<String, dynamic> toJSON() => {
        "id": id,
        "name": name,
        "description": description,
        "ingredients": ingredients.map((i) => i.toJSON()),
        "steps": steps.map((i) => i.toJSON()),
      };
}