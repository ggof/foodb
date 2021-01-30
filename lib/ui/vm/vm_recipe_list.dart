import 'package:foodb/core/domain/entities/recipe.dart';
import 'package:foodb/core/domain/repositories/recipe_repository.dart';
import 'package:foodb/ui/helpers/value_list_notifier.dart';
import 'package:foodb/ui/vm/vm.dart';

final mock = <Recipe>[
  Recipe(
    id: "mock1",
    name: "Recipe 1",
  ),
  Recipe(
    id: "mock2",
    name: "Recipe 2",
  ),
  Recipe(
    id: "mock3",
    name: "Recipe 3",
  ),
];

class VMRecipeList extends VM {
  List<Recipe> _list = mock;
  final filtered = ValueListNotifier<Recipe>(mock);

  final IRecipeRepository repository;

  VMRecipeList(this.repository);

  void init() {
    repository.subscribeToRecipeList().listen(onListUpdate);
  }

  void onListUpdate(List<Recipe> recipes) {

  }

  void filterBy(String value) {
    filtered.value = _list.where((element) => element.name.toLowerCase().contains(value.toLowerCase())).toList();
  }
}
