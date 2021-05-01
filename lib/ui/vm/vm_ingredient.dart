import 'package:flutter/foundation.dart';
import 'package:foodb/core/entities/ingredient.dart';
import 'package:foodb/ui/helpers/text_value.dart';

import 'vm.dart';

class VMIngredient extends VM {
  final name = ValueNotifier(TextValue());
  final quantity = ValueNotifier(TextValue());
  final unit = ValueNotifier(Unit.grams);

  VMIngredient(Ingredient ingredient) {
    name.value = TextValue(value: ingredient.name);
    quantity.value = TextValue(value: ingredient.quantity);
    unit.value = ingredient.unit;
  }

  void setName(String? value) => _setTextValue(name, value ?? "");

  void setQuantity(String? value) => _setTextValue(quantity, value ?? "");

  void setUnit(Unit? value) => unit.value = value ?? Unit.grams;

  _setTextValue(ValueNotifier<TextValue> notifier, String value) {
    final error = value.isEmpty ? "this field must not be empty" : "";
    notifier.value = TextValue(value: value, error: error);
  }

  Ingredient? get value =>
      name.value.error.isNotEmpty || quantity.value.error.isNotEmpty
          ? null
          : Ingredient(
              name: name.value.value,
              quantity: quantity.value.value,
              unit: unit.value,
            );
}
