import 'dart:convert';

import 'package:foodb/core/entities/recipe.dart';
import 'package:foodb/core/services/service.dart';
import 'package:hive/hive.dart';

class HiveRecipeService implements RecipeService {
  final LazyBox<String> box;
  final String key = "default";
  HiveRecipeService(this.box);
  @override
  Future<List<Recipe>> getAll() async {
    final json = await box.get(key, defaultValue: "[]");
    final List<dynamic> itemList = jsonDecode(json);
    final newState = itemList.map((i) => Recipe.fromJson(i)).toList();
    return newState;
  }

  @override
  Future<void> update(List<Recipe> state) async {
    final str = jsonEncode(state);
    return box.put(key, str);
  }
}
