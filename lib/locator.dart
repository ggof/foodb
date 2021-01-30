import 'package:foodb/core/domain/repositories/recipe_repository.dart';
import 'package:foodb/ui/vm/vm_recipe_list.dart';
import 'package:foodb/ui/vm/vm_recipe.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.I;

void initLocator() {
  _setupRepositories();
  _setupBlocs();
}

void _setupRepositories() {
  locator.registerLazySingleton<IRecipeRepository>(() => RecipeRepository());
}

void _setupBlocs() {
  locator.registerFactory(() => VMRecipeList(locator()));
  locator.registerFactory(() => VMRecipe(locator()));
}
