import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodb/core/entities/recipe.dart';

class CardRecipe extends StatelessWidget {
  final Recipe recipe;
  final void Function()? onPressed;
  final void Function()? onLongPress;

  const CardRecipe(this.recipe, {Key? key, this.onPressed, this.onLongPress}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        onPressed: onPressed,
        onLongPress: onLongPress,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: recipe.id,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.asset("images/food.png"),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(4, 8, 4, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    recipe.name,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Row(
                    children: [
                      Icon(Icons.local_fire_department),
                      Text(
                        recipe.calories.toString(),
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
