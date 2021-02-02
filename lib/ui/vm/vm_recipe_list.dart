import 'package:flutter/foundation.dart';
import 'package:foodb/core/domain/entities/recipe.dart';
import 'package:foodb/core/domain/repositories/recipe_repository.dart';
import 'package:foodb/ui/vm/vm.dart';


class VMRecipeList extends VM {
  final list = ValueNotifier<List<Recipe>>([]);
  final filtered = ValueNotifier<List<Recipe>>([]);
  var _filter = "";

  final IRecipeRepository repository;

  VMRecipeList(this.repository);

  void init() {
    setBusy();
    repository.subscribeToRecipeList(onUpdate);
  }

  void filterBy(String value) {
    _filter = value;
    filtered.value = list.value
        .where((element) =>
        element.name.toLowerCase().contains(_filter.toLowerCase()))
        .toList();
  }

  void onUpdate(List<Recipe> value) {
    list.value = value;
    filterBy(_filter);
    setIdle();
  }
}

typedef ProxyModifier<A, B> = B Function(A value);

class ProxyNotifier<A, B> with ChangeNotifier implements ValueListenable<B> {
  B _value;
  final ValueListenable<A> listenable;
  final ProxyModifier<A, B> modifier;

  ProxyNotifier(this.modifier, this.listenable) {
    listenable.addListener(update);
  }

  void update() {
    _value = modifier(listenable.value);
    notifyListeners();
  }

  @override
  // TODO: implement value
  B get value => _value;
}
