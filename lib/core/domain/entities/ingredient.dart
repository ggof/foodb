import 'model.dart';

abstract class Error {
  final String message;

  Error(this.message);
}

class InvalidUnitError extends Error {
  InvalidUnitError(String unit) : super("the unit $unit is not supported");
}

class Unit {
  final String name;

  Unit._(this.name);

  factory Unit.unit() => Unit._("");

  factory Unit.grams() => Unit._("grams");

  factory Unit.kilos() => Unit._("kilos");

  factory Unit.cups() => Unit._("cups");

  factory Unit.tablespoons() => Unit._("tablespoons");

  factory Unit.teaspoons() => Unit._("teaspoons");

  factory Unit.fromJSON(String unit) {
    switch (unit) {
      case "unit":
      case "grams":
      case "kilos":
      case "teaspoons":
      case "tablespoons":
      case "cups":
        return Unit._(unit);
      default:
        throw InvalidUnitError(unit);
    }
  }

  String toJSON() => name;
}

class Ingredient extends Model {
  final String name;
  final String quantity;
  final Unit unit;

  Ingredient({
    String id,
    this.name,
    this.quantity,
    this.unit,
  }) : super(id: id);

  factory Ingredient.fromJSON(Map<String, dynamic> json) => Ingredient(
        id: json["id"],
        name: json["name"],
        quantity: json["quantity"],
        unit: Unit.fromJSON(json["unit"]),
      );

  Map<String, dynamic> toJSON() => {
        "id": id,
        "name": name,
        "quantity": quantity,
        "unit": unit.toJSON(),
      };

  static bool isValid(Ingredient i) =>
      i.name.isNotEmpty && i.quantity.isNotEmpty && i.unit.name.isNotEmpty;
}
