import 'package:foodb/core/domain/entities/recipe.dart';
import 'package:foodb/core/domain/helpers/id_generator.dart';
import 'package:rxdart/rxdart.dart';

typedef SubscribeFunc<T> = void Function(T value);

abstract class IRecipeRepository {
  //sends data once recipe with this id changes
  Stream<Recipe> subscribeToRecipe(String id);

  // sends data once the list of recipes changes
  Stream<List<Recipe>> subscribeToRecipeList();

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
  List<Recipe> recipes = [];
  final recipeListSubject = BehaviorSubject<List<Recipe>>();

  final recipeSubjects = Map<String, BehaviorSubject<Recipe>>();

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
  Stream<Recipe> subscribeToRecipe(String id) {
    if (!recipeSubjects.containsKey(id)) {
      recipeSubjects[id] = BehaviorSubject.seeded(
        recipes.firstWhere(
          (e) => e.id == id,
          orElse: () => Recipe(),
        ),
      );
    }

    return recipeSubjects[id].stream;
  }

  @override
  Stream<List<Recipe>> subscribeToRecipeList() => recipeListSubject.stream;

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