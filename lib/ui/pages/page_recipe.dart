import 'package:flutter/material.dart' hide Step;
import 'package:foodb/core/domain/entities/ingredient.dart';
import 'package:foodb/core/domain/entities/step.dart';
import 'package:foodb/ui/components/bloc_loader.dart';
import 'package:foodb/ui/components/spacer.dart';
import 'package:foodb/ui/vm/vm_recipe.dart';

class PageRecipe extends StatelessWidget {
  final String id;

  const PageRecipe({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: null,
        body: VMLoader<VMRecipe>(
          onVMReady: (vm) => vm.init(id),
          builder: (context, bloc) => CustomScrollView(
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
                            ValueListenableBuilder<String>(
                              valueListenable: bloc.name,
                              builder: (context, value, _) => Text(value,
                                  style: Theme.of(context).textTheme.headline1),
                            ),
                            VerticalSpacer(16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Calories: 12",
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                                Text(
                                  "Protein: 40 grams",
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                              ],
                            ),
                            VerticalSpacer(16),
                            Text(
                              bloc.description.value,
                              style: Theme.of(context).textTheme.bodyText1,
                              textAlign: TextAlign.center,
                            ),
                            VerticalSpacer(64),
                            Text('Ingredients',
                                style: Theme.of(context).textTheme.headline2),
                            VerticalSpacer(16),
                            Divider(color: Colors.grey.shade400),
                            ValueListenableBuilder<List<Ingredient>>(
                              valueListenable: bloc.ingredients,
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
                              valueListenable: bloc.steps,
                              builder: (context, list, _) => Column(
                                children:
                                    list.map(toStepItem(context)).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
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
                    "${i.quantity} ${i.unit.name}",
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
