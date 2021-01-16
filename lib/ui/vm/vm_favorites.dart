import 'package:flutter/foundation.dart';
import 'package:foodb/core/domain/entities/recipe.dart';
import 'package:foodb/ui/vm/vm.dart';

class VMFavorites extends VM {
  final recipeList = ValueNotifier<List<Recipe>>(const []);
}
