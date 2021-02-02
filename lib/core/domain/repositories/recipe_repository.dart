import 'dart:async';

import 'package:foodb/core/domain/entities/ingredient.dart';
import 'package:foodb/core/domain/entities/recipe.dart';
import 'package:foodb/core/domain/entities/step.dart';
import 'package:foodb/core/domain/helpers/id_generator.dart';
import 'package:rxdart/rxdart.dart';

typedef SubscribeFunc<T> = void Function(T value);

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
      unit: Unit.grams(),
    ),
    Ingredient(
      id: "2",
      name: "Egg whites",
      quantity: "1/3",
      unit: Unit.cups(),
    ),
    Ingredient(
      id: "3",
      name: "Flour",
      quantity: "40",
      unit: Unit.grams(),
    ),
    Ingredient(
      id: "4",
      name: "Vanilla protein powder",
      quantity: "30",
      unit: Unit.grams(),
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

abstract class IRecipeRepository {
  //sends data once recipe with this id changes
  StreamSubscription<Recipe> subscribeToRecipe(
      String id, SubscribeFunc<Recipe> onUpdate);

  // sends data once the list of recipes changes
  StreamSubscription<List<Recipe>> subscribeToRecipeList(
      SubscribeFunc<List<Recipe>> onUpdate);

  // insert a recipe, notifying everyone listening to the list
  Future<void> insert(Recipe recipe);

  // delete a recipe, notifying everyone listening to the list
  // Calling this will CLOSE the single streams and cut their connection
  Future<void> delete(Recipe recipe);

  // update a recipe, notifying everyone listening to the list
  // AND anyone listening to this particular plan
  Future<void> update(Recipe recipe);
}

class RecipeRepository implements IRecipeRepository {
  List<Recipe> recipes = mock;
  final recipeListSubject = BehaviorSubject<List<Recipe>>();

  final recipeSubjects = Map<String, BehaviorSubject<Recipe>>();

  RecipeRepository() {
    recipeListSubject.sink.add(recipes);
  }

  @override
  Future<void> delete(Recipe recipe) async {
    recipes.remove(recipe);
    recipeListSubject.sink.add(recipes);
  }

  @override
  Future<void> insert(Recipe recipe) async {
    recipes.add(recipe.copyWith(id: IDGenerator.randomID(32)));
    recipeListSubject.sink.add(recipes);
  }

  @override
  Future<void> update(Recipe recipe) async {
    recipes.replaceWhere(recipe, (r) => r.id == recipe.id);
    if (recipeSubjects.containsKey(recipe.id)) {
      recipeSubjects[recipe.id].sink.add(recipe);
    }

    recipeListSubject.sink.add(recipes);
  }

  @override
  StreamSubscription<Recipe> subscribeToRecipe(
      String id, SubscribeFunc<Recipe> onUpdate) {
    if (!recipeSubjects.containsKey(id)) {
      recipeSubjects[id] = BehaviorSubject.seeded(
        recipes.firstWhere(
          (e) => e.id == id,
          orElse: () => Recipe(),
        ),
      );
    }

    return recipeSubjects[id].listen(onUpdate);
  }

  @override
  StreamSubscription<List<Recipe>> subscribeToRecipeList(
          SubscribeFunc<List<Recipe>> onUpdate) =>
      recipeListSubject.listen(onUpdate);

  void dispose() {
    recipeListSubject.close();
    recipeSubjects.forEach((key, value) => value.close());
    recipeSubjects.clear();
  }
}

extension Replacable<T> on List<T> {
  Iterable<T> replaceWhere(T value, bool Function(T) predicate) =>
      this.map((r) => predicate(r) ? value : r);
}
