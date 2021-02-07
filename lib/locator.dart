import 'package:foodb/core/entities/recipe.dart';
import 'package:foodb/core/rxvms/managers/recipe_list_manager.dart';
import 'package:foodb/ui/vm/vm_recipe_list.dart';
import 'package:foodb/ui/vm/vm_recipe.dart';
import 'package:get_it/get_it.dart';

import 'core/rxvms/managers/manager.dart';

final locator = GetIt.I;

void initLocator() {
  _setupManagers();
  _setupBlocs();
}

void _setupManagers() {
  locator.registerLazySingleton<Manager<List<Recipe>>>(
    () => RecipeListManager(mock),
  );
}

void _setupBlocs() {
  locator.registerFactory(() => VMRecipeList());
  locator.registerFactory(() => VMRecipe());
}
