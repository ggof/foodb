import 'package:flutter/foundation.dart';
import 'package:foodb/core/domain/entities/ingredient.dart';
import 'package:foodb/core/domain/entities/step.dart';
import 'package:foodb/ui/vm/vm.dart';

class VMRecipe extends VM {
  String _id = "";
  final isFavorite = ValueNotifier(false);
  final imageURL = ValueNotifier("");
  final name = ValueNotifier("");
  final description = ValueNotifier("");
  final ingredients = ValueNotifier(const <Ingredient>[]);
  final steps = ValueNotifier(const <Step>[]);

  //TODO: add use case here
  void init(String id) {
    _id = id;
    name.value = "Protein apple pie pancakes";
    imageURL.value = "images/food.png";
    description.value =
        "Four ingredients, delicious, quick and easy! You can also add cinamon to taste, a touch of lemon juice and a dash of ground ginger for even tastier results.";
    ingredients.value = [
      Ingredient(
          id: "1",
          name: "Unsweetned apple sauce",
          quantity: "120",
          unit: Unit.grams()),
      Ingredient(
          id: "2", name: "Egg whites", quantity: "1/3", unit: Unit.cups()),
      Ingredient(id: "3", name: "Flour", quantity: "40", unit: Unit.grams()),
      Ingredient(
          id: "4",
          name: "Vanilla protein powder",
          quantity: "30",
          unit: Unit.grams()),
    ];
    steps.value = [
      Step(id: "1", description: "pour all the wet ingredients in a bowl. "),
      Step(id: "2", description: "Mix thoroughly."),
      Step(id: "3", description: "Add the dry ingredients. "),
      Step(id: "4", description: "Mix thoroughly."),
      Step(
          id: "5",
          description:
              "cook in batches for about 2-3 minutes each side. I like mine 3 to 4 inches in diameter. "),
    ];
  }

  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
    print("toggling favorite for $_id");
  }
}
