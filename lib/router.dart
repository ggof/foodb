import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodb/ui/pages/page_add_recipe.dart';
import 'package:foodb/ui/pages/page_recipe_list.dart';
import 'package:foodb/ui/pages/page_recipe.dart';

Route<dynamic> onGenerateRoute(RouteSettings params) {
  switch (params.name) {
    case routeRecipesAdd:
      final id = params.arguments == null ? "" : (params.arguments as Map<String, dynamic>)["id"];
      return MaterialPageRoute(builder: (context) => PageAddRecipe(id: id));
    case routerecipesSingle:
      return MaterialPageRoute(
          builder: (context) =>
              PageRecipe(id: (params.arguments as Map<String, dynamic>)["id"]));
    case routeHome:
    case routeRecipes:
    default:
      return MaterialPageRoute(builder: (context) => PageRecipeList());
  }
}

const routeHome = "/recipes";
const routeRecipes = "/recipes";
const routerecipesSingle = "/recipes/single";
const routeRecipesAdd = "/recipes/add";