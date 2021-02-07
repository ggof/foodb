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

final mockRecipe = Recipe(
  id: "mock",
  name: "Protein apple pie pancakes",
  image: "images/food.png",
  description:
      "Four ingredients, delicious, quick and easy! You can also add cinamon to taste, a touch of lemon juice and a dash of ground ginger for even tastier results.",
  ingredients: [
    Ingredient(
      id: "1",
      name: "Unsweetned apple sauce",
      quantity: "120",
      unit: Unit.grams,
    ),
    Ingredient(
      id: "2",
      name: "Egg whites",
      quantity: "1/3",
      unit: Unit.cups,
    ),
    Ingredient(
      id: "3",
      name: "Flour",
      quantity: "40",
      unit: Unit.grams,
    ),
    Ingredient(
      id: "4",
      name: "Vanilla protein powder",
      quantity: "30",
      unit: Unit.grams,
    ),
  ],
  steps: [
    Step(id: "1", description: "pour all the wet ingredients in a bowl. "),
    Step(id: "2", description: "Mix thoroughly."),
    Step(id: "3", description: "Add the dry ingredients. "),
    Step(id: "4", description: "Mix thoroughly."),
    Step(
        id: "5",
        description:
            "cook in batches for about 2-3 minutes each side. I like mine 3 to 4 inches in diameter. "),
  ],
);

final mock = <Recipe>[
  Recipe(
    id: "mock1",
    name: "Recipe 1",
  ),
  Recipe(
    id: "mock2",
    name: "Recipe 2",
  ),
  Recipe(
    id: "mock3",
    name: "Recipe 3",
  ),
  mockRecipe,
];