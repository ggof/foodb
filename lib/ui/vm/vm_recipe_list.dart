import 'package:flutter/foundation.dart';
import 'package:foodb/core/entities/recipe.dart';
import 'package:foodb/core/rxvms/options/options.dart';
import 'package:foodb/core/rxvms/managers/manager.dart';
import 'package:foodb/core/rxvms/managers/recipe_list_manager.dart';
import 'package:foodb/locator.dart';
import 'package:foodb/ui/vm/vm.dart';

class VMRecipeList extends VM {
  final list = ValueNotifier<Iterable<Recipe>>([]);
  final Manager<List<Recipe>> manager = locator();

  VMRecipeList() {
    manager.subscribe(onUpdate);
  }

  void init() {
    manager.execute(this, GetAllCommand(),
        onLoading: SetLoading(), onSuccess: StopLoading());
  }

  void setFilter(String value) =>
      manager.execute(this, GetFilteredCommand(value, onUpdate));

  Future<void> refresh() => manager.execute(
        this,
        GetAllCommand(),
        onLoading: DoNothing(),
        onSuccess: StopLoading(),
      );

  void onUpdate(Iterable<Recipe> value) {
    list.value = value;

    if (this.state.runtimeType != Idle) {
      setIdle();
    }
  }
}
