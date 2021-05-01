import 'package:flutter/material.dart';
import 'package:foodb/ui/components/item_ingredient.dart';
import 'package:foodb/ui/components/item_step.dart';
import 'package:foodb/ui/components/notifiable_text_box.dart';
import 'package:foodb/ui/components/vm_loader.dart';
import 'package:foodb/ui/components/spacer.dart';
import 'package:foodb/ui/vm/vm.dart';
import 'package:foodb/ui/vm/vm_ingredient.dart';
import 'package:foodb/ui/vm/vm_recipe.dart';
import 'package:foodb/ui/vm/vm_step.dart';

class PageAddRecipe extends StatelessWidget {
  final String? id;

  PageAddRecipe({this.id});

  @override
  Widget build(BuildContext context) => VMLoader<VMRecipe>(
        (context, vm) => ValueListenableBuilder<ViewState>(
          valueListenable: vm.state,
          builder: (context, state, _) {
            if (state is Busy) {
              return Center(child: CircularProgressIndicator());
            }

            return Scaffold(
              body: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      PageHeader(vm.submit),
                      NotifiableTextBox(
                        vm.name,
                        onChanged: vm.setName,
                        hintText: "Name",
                      ),
                      VerticalSpacer(8),
                      NotifiableTextBox(
                        vm.description,
                        onChanged: vm.setDesc,
                        hintText: "Description",
                        lines: 8,
                      ),
                      VerticalSpacer(8),
                      NotifiableTextBox(
                        vm.calories,
                        onChanged: vm.setCalories,
                        hintText: "Calories",
                        keyboardType: TextInputType.number,
                      ),
                      VerticalSpacer(8),
                      NotifiableTextBox(
                        vm.proteins,
                        onChanged: vm.setProteins,
                        hintText: "Proteins",
                        keyboardType: TextInputType.number,
                      ),
                      VerticalSpacer(8),
                      NotifiableTextBox(
                        vm.servings,
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
                            onPressed: vm.addIngredient,
                          ),
                        ],
                      ),
                      VerticalSpacer(8),
                      ValueListenableBuilder<List<VMIngredient>>(
                        valueListenable: vm.ingredients,
                        builder: (context, list, _) => Column(
                          children: [
                            for (final i in list)
                              ItemIngredient(
                                i,
                                vm.removeIngredient,
                              ),
                          ],
                        ),
                      ),
                      VerticalSpacer(16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Steps",
                              style: Theme.of(context).textTheme.headline1),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: vm.addStep,
                          ),
                        ],
                      ),
                      VerticalSpacer(8),
                      ValueListenableBuilder<List<VMStep>>(
                        valueListenable: vm.steps,
                        builder: (context, list, _) => Column(
                          children: [
                            for (final i in list)
                              ItemStep(
                                i,
                                vm.removeStep,
                              )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        onVMReady: (vm) => vm.init(id),
      );
}

class PageHeader extends StatelessWidget {
  final void Function() submit;

  const PageHeader(this.submit);

  @override
  Widget build(BuildContext context) => Container(
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
            Text(
              "Details",
              style: Theme.of(context).textTheme.headline1,
            ),
            IconButton(
              onPressed: submit,
              icon: Icon(Icons.done_rounded),
            ),
          ],
        ),
      );

  void goBack(BuildContext context) async {
    final answer = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
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

    if (answer ?? false) {
      Navigator.of(context).pop();
    }
  }
}
