import 'package:flutter/material.dart';
import 'package:foodb/core/entities/ingredient.dart';
import 'package:foodb/ui/components/spacer.dart';
import 'package:foodb/ui/components/text_box.dart';

class IngredientItem extends StatelessWidget {
  final Ingredient ingredient;
  final void Function(Unit) onSelected;

  const IngredientItem({Key key, this.ingredient, this.onSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextBox(
          hintText: "Ingredient",
        ),
        VerticalSpacer(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 3,
              child: TextBox(
                hintText: "Quantity",
                keyboardType: TextInputType.number,
              ),
            ),
            Flexible(
              flex: 2,
              child: DropdownButton<Unit>(
                hint: Text("Unit"),
                onChanged: onSelected,
                items: Unit.values
                    .map(
                      (u) => DropdownMenuItem<Unit>(
                        child: Text(
                          UnitHelper.toValue(u),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
        Divider(
          color: Colors.grey.shade400,
          thickness: 1,
          height: 32,
          indent: 8,
          endIndent: 8,
        ),
      ],
    );
  }
}
