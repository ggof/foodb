import 'package:flutter/foundation.dart';
import 'package:foodb/core/entities/ingredient.dart';
import 'package:foodb/core/entities/recipe.dart';
import 'package:foodb/core/entities/step.dart';
import 'package:foodb/core/rxvms/commands/command.dart';
import 'package:foodb/core/rxvms/managers/recipe_list_manager.dart';
import 'package:foodb/router.dart';
import 'package:foodb/ui/helpers/list_notifier.dart';
import 'package:foodb/ui/helpers/text_value.dart';
import 'package:foodb/ui/vm/vm.dart';

import '../../locator.dart';

class VMRecipe extends VM implements CommandPresenter {
  String _id = "";

  String get id => _id;
  final image = ValueNotifier(TextValue());
  final name = ValueNotifier(TextValue());
  final description = ValueNotifier(TextValue());
  final ingredients = ListNotifier(const <Ingredient>[]);
  final steps = ListNotifier(const <Step>[]);
  final calories = ValueNotifier(TextValue());
  final proteins = ValueNotifier(TextValue());
  final servings = ValueNotifier(TextValue());

  final RecipeListManager manager = locator();

  void init(String id) {
    if (id == null) return;
    _id = id;
    manager.execute(this, GetSingleCommand(id, onUpdate));
  }

  void onUpdate(Recipe value) {
    name.value = TextValue(value: value.name);
    description.value = TextValue(value: value.description);
    calories.value = TextValue(value: value.calories.toString());
    proteins.value = TextValue(value: value.proteins.toString());
    servings.value = TextValue(value: value.servings.toString());
    image.value = TextValue(value: value.image);
    steps.value = value.steps;
    ingredients.value = value.ingredients;

    setIdle();
  }

  void setName(String value) {
    final error = value.isNotEmpty ? "" : "this field must not be empty";
    name.value = TextValue(value: value, error: error);
  }

  void setDesc(String value) => description.value = TextValue(value: value);

  void setCalories(String value) => _setInteger(calories, value);
  void setProteins(String value) => _setInteger(proteins, value);
  void setServings(String value) => _setInteger(servings, value);

  void _setInteger(ValueNotifier<TextValue> notifier, String value) {
    String setError() {
      if (value.isEmpty) return "this field must not be empty";
      if (int.tryParse(value) == null)
        return "this field must be a valid number";
      return "";
    }

    final error = setError();
    notifier.value = TextValue(value: value, error: error);
  }

  Future<void> submit() async {
    final value = Recipe(
      id: id,
      name: name.value.value,
      description: description.value.value,
      image: image.value.value,
      ingredients: ingredients.value,
      steps: steps.value,
      calories: int.tryParse(calories.value.value),
      proteins: int.tryParse(proteins.value.value),
      servings: int.tryParse(servings.value.value),
    );

    bool errors = false;
    if (value.name.isEmpty) {
      name.value = name.value.copyWith(error: "this field must not be empty");
      errors = true;
    }

    if (value.ingredients.isEmpty || value.steps.isEmpty) {
      errors = true;
    }

    if (value.calories == null || value.proteins == null || value.servings == null) {
      errors = true;
    }

    if (errors) return;

    final Command<List<Recipe>> command =
        id == null ? InsertCommand(value) : UpdateCommand(value);

    manager.execute(this, command);
  }

  @override
  void onError(String error) => print(error);

  @override
  void onLoading() => setBusy();

  @override
  void onSuccess() {
    setIdle();
    navigate(NavigationEvent(routeRecipes));
  }
}
