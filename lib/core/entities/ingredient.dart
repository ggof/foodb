import 'model.dart';

abstract class Error {
  final String message;

  Error(this.message);
}

class InvalidUnitError extends Error {
  InvalidUnitError(String unit) : super("the unit $unit is not supported");
}

enum Unit {
  grams,
  kilos,
  cups,
  tablespoons,
  teaspoons,
  whole,
}

class UnitHelper {
  static Unit fromJSON(String value) =>
      Unit.values.firstWhere((u) => u.toString() == value);

  static String toJSON(Unit value) => value.toString();

  static String toValue(Unit value) => value.toString().split(".").last;
}

class Ingredient extends Model {
  final String name;
  final String quantity;
  final Unit unit;

  Ingredient({
    String id = "",
    this.name = "",
    this.quantity = "",
    this.unit = Unit.grams,
  }) : super(id);

  factory Ingredient.fromJSON(Map<String, dynamic> json) => Ingredient(
        id: json["id"],
        name: json["name"],
        quantity: json["quantity"],
        unit: UnitHelper.fromJSON(json["unit"]),
      );

  Map<String, dynamic> toJSON() => {
        "id": id,
        "name": name,
        "quantity": quantity,
        "unit": UnitHelper.toJSON(unit),
      };

  static bool isValid(Ingredient i) =>
      i.name.isNotEmpty && i.quantity.isNotEmpty;
}
