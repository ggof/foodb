import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodb/ui/pages/page_add_recipe.dart';
import 'package:foodb/ui/pages/page_recipe_list.dart';
import 'package:foodb/ui/pages/page_recipe.dart';

Route<dynamic> onGenerateRoute(RouteSettings params) {
  switch (params.name) {
    case '/recipes/add':
      return MaterialPageRoute(builder: (context) => PageAddRecipe());
    case '/recipes/single':
      return MaterialPageRoute(
          builder: (context) =>
              PageRecipe(id: (params.arguments as Map<String, dynamic>)["id"]));
    case '/home':
    case '/recipes':
    default:
      return MaterialPageRoute(builder: (context) => PageRecipeList());
  }
}
