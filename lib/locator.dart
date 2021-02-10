import 'package:foodb/core/entities/recipe.dart';
import 'package:foodb/core/rxvms/managers/recipe_list_manager.dart';
import 'package:foodb/core/services/hive_service.dart';
import 'package:foodb/core/services/service.dart';
import 'package:foodb/ui/vm/vm_recipe_list.dart';
import 'package:foodb/ui/vm/vm_recipe.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import 'core/rxvms/managers/manager.dart';

final locator = GetIt.I;

Future<void> initLocator() async {
  await _setupServices();
  _setupManagers();
  _setupBlocs();
}

Future<void> _setupServices() async {
  final box = await Hive.openLazyBox<String>("recipes");
  locator.registerLazySingleton<RecipeService>(() => HiveRecipeService(box));
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
