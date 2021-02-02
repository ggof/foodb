import 'package:flutter/foundation.dart';
import 'package:foodb/core/domain/entities/ingredient.dart';
import 'package:foodb/core/domain/entities/recipe.dart';
import 'package:foodb/core/domain/entities/step.dart';
import 'package:foodb/core/domain/repositories/recipe_repository.dart';
import 'package:foodb/ui/helpers/list_notifier.dart';
import 'package:foodb/ui/vm/vm.dart';

import '../../router.dart';

class VMRecipe extends VM {
  String _id = "";

  String get id => _id;
  final image = ValueNotifier("");
  final name = ValueNotifier("");
  final description = ValueNotifier("");
  final ingredients = ListNotifier(const <Ingredient>[]);
  final steps = ListNotifier(const <Step>[]);
  final errors = ListNotifier(const <String>[]);
  final calories = ValueNotifier(0);
  final proteins = ValueNotifier(0);
  final servings = ValueNotifier(1);

  final IRecipeRepository repository;

  VMRecipe(this.repository);

  void init(String id) {
    if (id == null) return;

    _id = id;

    repository.subscribeToRecipe(_id, onUpdate);
  }

  void onUpdate(Recipe value) {
    name.value = value.name;
    description.value = value.description;
    ingredients.value = value.ingredients;
    calories.value = value.calories;
    proteins.value = value.proteins;
    servings.value = value.servings;
    steps.value = value.steps;
    image.value = value.image;

    setIdle();
  }

  void setName(String value) => name.value = value;

  void setDesc(String value) => description.value = value;

  Future<void> submit() async {
    final value = Recipe(
      id: id,
      name: name.value,
      description: description.value,
      image: image.value,
      ingredients: ingredients.value,
      steps: steps.value,
      calories: calories.value,
      proteins: proteins.value,
      servings: servings.value,
    );

    final localErrors = <String>[];
    if (value.name.isEmpty) {
      localErrors.add("Name must not be empty");
    }

    if (value.ingredients.isEmpty || value.steps.isEmpty) {
      localErrors.add("Ingredients and steps must not be empty");
    }

    if (localErrors.isNotEmpty) {
      errors.value = localErrors;
      return;
    }

    id == null
        ? await repository.insert(value)
        : await repository.update(value.copyWith(id: id));
    navigate(NavigationEvent(routeRecipes));
  }
}

class TextValue {
  final String value;
  final String error;

  const TextValue({this.value, this.error});

  TextValue copyWith({String value, String error}) => TextValue(
        value: value ?? this.value,
        error: error ?? this.error,
      );
}
