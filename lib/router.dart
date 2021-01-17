import 'package:flutter/material.dart';
import 'package:foodb/ui/pages/page_favorites.dart';
import 'package:foodb/ui/pages/page_recipe.dart';

Route<dynamic> onGenerateRoute(RouteSettings params) {
  switch (params.name) {
    case '/home':
      return MaterialPageRoute(builder: (context) => PageFavorites());
    case '/recipe':
      return MaterialPageRoute(
          builder: (context) =>
              PageRecipe(id: (params.arguments as Map<String, dynamic>)["id"]));
  }
}
