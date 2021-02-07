import 'package:flutter/material.dart';
import 'package:foodb/core/entities/ingredient.dart';
import 'package:foodb/ui/components/ingredient_item.dart';
import 'package:foodb/ui/components/notifiable_text_box.dart';
import 'package:foodb/ui/components/vm_loader.dart';
import 'package:foodb/ui/components/spacer.dart';
import 'package:foodb/ui/vm/vm_recipe.dart';

class PageAddRecipe extends StatelessWidget {
  final nameController = TextEditingController();
  final descController = TextEditingController();

  final String id;

  PageAddRecipe({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) => VMLoader<VMRecipe>(
        onVMReady: (vm) => vm.init(id),
        builder: (context, vm) => Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverPersistentHeader(delegate: _Header(vm.submit)),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Text(
                        "Details",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      NotifiableTextBox(
                        listenable: vm.name,
                        onChanged: vm.setName,
                        hintText: "Name",
                      ),
                      VerticalSpacer(8),
                      NotifiableTextBox(
                        listenable: vm.description,
                        onChanged: vm.setDesc,
                        hintText: "Description",
                        lines: 8,
                      ),
                      VerticalSpacer(8),
                      NotifiableTextBox(
                        listenable: vm.calories,
                        onChanged: vm.setCalories,
                        hintText: "Calories",
                        keyboardType: TextInputType.number,
                      ),
                      VerticalSpacer(8),
                      NotifiableTextBox(
                        listenable: vm.proteins,
                        onChanged: vm.setProteins,
                        hintText: "Proteins",
                        keyboardType: TextInputType.number,
                      ),
                      VerticalSpacer(8),
                      NotifiableTextBox(
                        listenable: vm.servings,
                        onChanged: vm.setServings,
                        hintText: "Servings",
                        keyboardType: TextInputType.number,
                      ),
                      VerticalSpacer(16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Ingredients",
                              style: Theme.of(context).textTheme.headline1),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      VerticalSpacer(8),
                      for (final i in vm.ingredients.value)
                        IngredientItem(
                          ingredient: i,
                          onSelected: print,
                        ),
                      VerticalSpacer(16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Steps",
                              style: Theme.of(context).textTheme.headline1),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      VerticalSpacer(8),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

class _Header extends SliverPersistentHeaderDelegate {
  final double size = 80;
  final void Function() submit;

  _Header(this.submit);

  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      Container(
        padding: const EdgeInsets.only(
          top: 40,
          left: 8,
          right: 8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () => goBack(context),
              icon: Icon(Icons.arrow_back_ios_rounded),
            ),
            IconButton(
              onPressed: submit,
              icon: Icon(Icons.done_rounded),
            ),
          ],
        ),
      );

  double get maxExtent => size;

  double get minExtent => size;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;

  void goBack(BuildContext context) async {
    final answer = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Are you sure?"),
        content: Text("all progress will be lost."),
        actions: [
          MaterialButton(
            child: Text("yes"),
            onPressed: () => Navigator.of(context).pop(true),
          ),
          MaterialButton(
            child: Text("No"),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        ],
      ),
    );

    if (answer) {
      Navigator.of(context).pop();
    }
  }
}
