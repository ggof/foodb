import 'package:flutter/material.dart';
import 'package:foodb/ui/pages/page_add_recipe.dart';
import 'package:foodb/ui/pages/page_favorites.dart';
import 'package:foodb/ui/pages/tabbed_page.dart';

class PageMain extends StatelessWidget {
  final pages = <WidgetFactory>[
    () => PageFavorites(),
    () => PageAddRecipe(),
  ];
  final items = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
        icon: Icon(Icons.favorite_border), label: "Favorites"),

    BottomNavigationBarItem(
        icon: Icon(Icons.add), label: "Add"),
  ];

  @override
  Widget build(BuildContext context) => TabbedPage(
        pages: pages,
        items: items,
      );
}
