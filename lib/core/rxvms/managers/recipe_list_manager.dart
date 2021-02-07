import 'package:foodb/core/entities/recipe.dart';
import 'package:foodb/core/errors/not_found_error.dart';
import 'package:foodb/core/helpers/id_generator.dart';
import 'package:foodb/core/rxvms/commands/command.dart';

import 'manager.dart';

class RecipeListManager extends Manager<List<Recipe>> {
  RecipeListManager([List<Recipe> initialState = const []])
      : super(initialState);
}

//TODO: move commands in separate file?

class GetSingleCommand extends Command<List<Recipe>> {
  final String id;
  final UpdateCallback<Recipe> onValue;
  GetSingleCommand(this.id, this.onValue);

  @override
  Future<List<Recipe>> call(List<Recipe> state) async {
    final value = state.firstWhere((element) => element.id == id);

    if (value == null) {
      throw NotFoundError("Recipe with id $id was not found");
    }

    onValue(value);

    return null;
  }
}

class GetAllCommand extends Command<List<Recipe>> {
  @override
  Future<List<Recipe>> call(List<Recipe> state) {
    // TODO: fetch all recipes and return them
    return null;
  }
}

class GetFilteredCommand extends Command<List<Recipe>> {
  final UpdateCallback<Iterable<Recipe>> onFiltered;
  final String filter;
  GetFilteredCommand(this.filter, this.onFiltered);

  @override
  Future<List<Recipe>> call(List<Recipe> state) {
    onFiltered(state
        .where((e) => e.name.toLowerCase().contains(filter.toLowerCase())));
    return null;
  }
}

class InsertCommand extends Command<List<Recipe>> {
  final Recipe value;
  InsertCommand(this.value);

  @override
  Future<List<Recipe>> call(List<Recipe> state) async =>
      [...state, value.copyWith(id: IDGenerator.randomID())];
}

class UpdateCommand extends Command<List<Recipe>> {
  final Recipe value;
  UpdateCommand(this.value);

  @override
  // Remove old value, add new one. Order is not preserved...
  Future<List<Recipe>> call(List<Recipe> state) async =>
      [...state.where((e) => e.id != value.id), value];
}
