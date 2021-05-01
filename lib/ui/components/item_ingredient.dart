import 'package:flutter/material.dart';
import 'package:foodb/core/entities/ingredient.dart';
import 'package:foodb/ui/components/spacer.dart';
import 'package:foodb/ui/vm/vm_ingredient.dart';

import 'notifiable_text_box.dart';

class ItemIngredient extends StatelessWidget {
  final VMIngredient vm;
  final void Function(VMIngredient) onDelete;

  const ItemIngredient(this.vm, this.onDelete);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              flex: 1,
              child: NotifiableTextBox(
                vm.name,
                onChanged: vm.setName,
                hintText: "Ingredient",
              ),
            ),
            IconButton(
              padding: const EdgeInsets.all(8),
              icon: Icon(
                Icons.delete,
                color: Color(0xFFFF6666),
              ),
              onPressed: () => onDelete(vm),
            ),
          ],
        ),
        VerticalSpacer(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 3,
              child: NotifiableTextBox(
                vm.quantity,
                onChanged: vm.setQuantity,
                hintText: "Quantity",
                keyboardType: TextInputType.number,
              ),
            ),
            Flexible(
              flex: 2,
              child: ValueListenableBuilder<Unit>(
                valueListenable: vm.unit,
                builder: (context, unit, _) => DropdownButton<Unit>(
                  value: unit,
                  hint: Text("Unit"),
                  onChanged: vm.setUnit,
                  style: Theme.of(context).textTheme.headline3,
                  dropdownColor: Theme.of(context).dialogBackgroundColor,
                  items: Unit.values
                      .map(
                        (u) => DropdownMenuItem<Unit>(
                          value: u,
                          child: Text(
                            UnitHelper.toValue(u),
                          ),
                        ),
                      )
                      .toList(),
                ),
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
