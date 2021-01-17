import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
                delegate: _Header(),
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
                          color: Colors.white,
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
}

class _Header extends SliverPersistentHeaderDelegate {
  _Header() : super();

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
            child: Container(
              padding: EdgeInsets.only(top: 32),
              color: Theme.of(context).accentColor,
              child: Image.asset("images/food.png", fit: BoxFit.contain),
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
                Icon(Icons.favorite_outline),
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
