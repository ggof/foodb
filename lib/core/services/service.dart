import 'package:foodb/core/entities/recipe.dart';

abstract class RecipeService {
  Future<List<Recipe>> getAll();
  Future<void> update(List<Recipe> state);
}
