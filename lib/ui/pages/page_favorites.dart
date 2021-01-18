import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodb/core/domain/entities/recipe.dart';
import 'package:foodb/ui/components/bloc_loader.dart';
import 'package:foodb/ui/components/card_recipe.dart';
import 'package:foodb/ui/vm/vm_favorites.dart';

final mock = <Recipe>[
  Recipe(
    id: "mock1",
    name: "Recipe 1",
  ),
  Recipe(
    id: "mock2",
    name: "Recipe 1",
  ),
  Recipe(
    id: "mock3",
    name: "Recipe 1",
  ),
];

class PageFavorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) => VMLoader<VMFavorites>(
        builder: (context, bloc) => CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            SliverAppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  shape: BoxShape.rectangle,
                  color: Theme.of(context).accentColor,
                ),
                margin: const EdgeInsets.all(4),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: TextField(
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    hintText: "search something ...",
                    focusColor: Color(0xFF101010),
                    prefixIcon: Icon(Icons.search, color: Color(0xFFB8BFD4)),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  ...mock
                      .map(
                        (t) => CardRecipe(
                          recipe: t,
                        ),
                      )
                      .toList(),
                ],
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 24),
            ),
          ],
        ),
      );
}
