import 'package:flutter/foundation.dart';
import 'package:foodb/core/entities/recipe.dart';
import 'package:foodb/core/rxvms/commands/command.dart';
import 'package:foodb/core/rxvms/commands/success_option.dart';
import 'package:foodb/core/rxvms/managers/manager.dart';
import 'package:foodb/core/rxvms/managers/recipe_list_manager.dart';
import 'package:foodb/locator.dart';
import 'package:foodb/ui/vm/vm.dart';

class VMRecipeList extends VM implements CommandPresenter {
  final list = ValueNotifier<Iterable<Recipe>>([]);
  final Manager<List<Recipe>> manager = locator();

  VMRecipeList() {
    manager.subscribe(onUpdate);
  }

  void init() {
    manager.execute(this, GetAllCommand(), DoNothing());
  }

  void setFilter(String value) => manager.execute(
        this,
        GetFilteredCommand(value, onUpdate),
        DoNothing(),
      );

  void onUpdate(Iterable<Recipe> value) {
    list.value = value;

    if (this.state.runtimeType != Idle) {
      setIdle();
    }
  }

  @override
  //TODO: change this
  onError(String error) => print(error);

  @override
  void onLoading() => setBusy();

  @override
  void onSuccess(SuccessOption option) => option(this);
}
