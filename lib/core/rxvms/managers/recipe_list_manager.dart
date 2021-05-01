import 'package:foodb/core/entities/recipe.dart';
import 'package:foodb/core/errors/not_found_error.dart';
import 'package:foodb/core/helpers/id_generator.dart';
import 'package:foodb/core/rxvms/commands/command.dart';
import 'package:foodb/core/services/service.dart';
import 'package:foodb/locator.dart';

import 'manager.dart';

class RecipeListManager extends BaseManager<List<Recipe>> {
  RecipeListManager([List<Recipe> initialState = const []])
      : super(initialState);
}

class GetSingleCommand extends Command<List<Recipe>> {
  final String id;
  final UpdateCallback<Recipe> onValue;

  GetSingleCommand(this.id, this.onValue);

  @override
  Future<List<Recipe>?> call(List<Recipe> state) async {
    try {
      final value = state.firstWhere((element) => element.id == id);
      onValue(value);

      return null;
    } on StateError {
      throw NotFoundError("Recipe with id $id was not found");
    }
  }
}

class GetAllCommand extends Command<List<Recipe>> {
  final RecipeService service = locator();

  @override
  Future<List<Recipe>?> call(List<Recipe> state) async => service.getAll();
}

class GetFilteredCommand extends Command<List<Recipe>> {
  final UpdateCallback<Iterable<Recipe>> onFiltered;
  final String filter;

  GetFilteredCommand(this.filter, this.onFiltered);

  @override
  Future<List<Recipe>?> call(List<Recipe> state) async {
    onFiltered(state
        .where((e) => e.name.toLowerCase().contains(filter.toLowerCase())));
    return null;
  }
}

class InsertCommand extends Command<List<Recipe>> {
  final RecipeService service = locator();

  final Recipe value;

  InsertCommand(this.value);

  @override
  Future<List<Recipe>> call(List<Recipe> state) async {
    final newState = [...state, value.copyWith(id: IDGenerator.randomID())];
    await service.update(newState);
    return newState;
  }
}

class UpdateCommand extends Command<List<Recipe>> {
  final RecipeService service = locator();

  final Recipe value;

  UpdateCommand(this.value);

  @override
  // Remove old value, add new one. Order is not preserved...
  Future<List<Recipe>> call(List<Recipe> state) async {
    final newState = [...state.where((e) => e.id != value.id), value].toList();
    await service.update(newState);
    return newState;
  }
}

class DeleteCommand extends Command<List<Recipe>> {
  final RecipeService service = locator();
  final Recipe value;

  DeleteCommand(this.value);

  @override
  Future<List<Recipe>?> call(List<Recipe> state) async {
    final newState = state.where((e) => e.id != value.id).toList();
    await service.update(newState);
    return newState;
  }
}
