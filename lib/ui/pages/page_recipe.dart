import 'package:flutter/material.dart' hide Step;
import 'package:foodb/core/entities/ingredient.dart';
import 'package:foodb/core/entities/step.dart';
import 'package:foodb/router.dart';
import 'package:foodb/ui/components/vm_loader.dart';
import 'package:foodb/ui/components/spacer.dart';
import 'package:foodb/ui/helpers/text_value.dart';
import 'package:foodb/ui/vm/vm_recipe.dart';

class PageRecipe extends StatelessWidget {
  final String id;

  const PageRecipe({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) => VMLoader<VMRecipe>(
        onVMReady: (vm) => vm.init(id),
        builder: (context, vm) => Scaffold(
          appBar: null,
          body: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: _Header(id: id),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        decoration: BoxDecoration(
                          color: Theme.of(context).dialogBackgroundColor,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(32),
                          ),
                        ),
                        child: Column(
                          children: [
                            VerticalSpacer(40),
                            ValueListenableBuilder<TextValue>(
                              valueListenable: vm.name,
                              builder: (context, value, _) => Text(value.value,
                                  style: Theme.of(context).textTheme.headline1),
                            ),
                            VerticalSpacer(16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ValueListenableBuilder<TextValue>(
                                  valueListenable: vm.calories,
                                  builder: (context, value, _) => Text(
                                    "Calories: ${value.value}",
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                ),
                                ValueListenableBuilder<TextValue>(
                                  valueListenable: vm.proteins,
                                  builder: (context, value, _) => Text(
                                    "Protein: ${value.value} grams",
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                ),
                              ],
                            ),
                            VerticalSpacer(16),
                            ValueListenableBuilder<TextValue>(
                              valueListenable: vm.description,
                              builder: (context, value, _) => Text(
                                value.value ?? "No description provided",
                                style: Theme.of(context).textTheme.bodyText1,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            VerticalSpacer(64),
                            Text('Ingredients',
                                style: Theme.of(context).textTheme.headline2),
                            VerticalSpacer(16),
                            Divider(color: Colors.grey.shade400),
                            ValueListenableBuilder<List<Ingredient>>(
                              valueListenable: vm.ingredients,
                              builder: (context, list, _) => Column(
                                children: list
                                    .map(toIngredientItem(context))
                                    .toList(),
                              ),
                            ),
                            VerticalSpacer(32),
                            Text('Steps',
                                style: Theme.of(context).textTheme.headline2),
                            VerticalSpacer(16),
                            Divider(color: Colors.grey.shade400),
                            ValueListenableBuilder<List<Step>>(
                              valueListenable: vm.steps,
                              builder: (context, list, _) => Column(
                                children:
                                    list.map(toStepItem(context)).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget Function(Ingredient) toIngredientItem(BuildContext context) =>
      (Ingredient i) => Column(
            children: [
              VerticalSpacer(8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    i.name,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    "${i.quantity} ${UnitHelper.toValue(i.unit)}",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              VerticalSpacer(8),
              Divider(color: Colors.grey.shade400)
            ],
          );

  Widget Function(Step) toStepItem(BuildContext context) => (Step i) => Column(
        children: [
          VerticalSpacer(8),
          Text(
            i.description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          VerticalSpacer(8),
          Divider(color: Colors.grey.shade400)
        ],
      );
}

class _Header extends SliverPersistentHeaderDelegate {
  final String id;

  _Header({this.id}) : super();

  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: -shrinkOffset,
            height: 256,
            left: 0,
            right: 0,
            child: Hero(
              tag: id,
              child: Container(
                padding: EdgeInsets.only(top: 32),
                color: Theme.of(context).accentColor,
                child: Image.asset("images/food.png", fit: BoxFit.contain),
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 8,
            right: 8,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => Navigator.of(context)
                      .pushNamed(routeRecipesAdd, arguments: {"id": id}),
                ),
              ],
            ),
          ),
        ],
      );

  @override
  double get maxExtent => 256;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
