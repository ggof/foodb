import 'package:flutter/material.dart';
import 'package:foodb/ui/components/bloc_loader.dart';
import 'package:foodb/ui/components/spacer.dart';
import 'package:foodb/ui/components/text_box.dart';
import 'package:foodb/ui/vm/vm_recipe.dart';

class PageAddRecipe extends StatelessWidget {
  @override
  Widget build(BuildContext context) => VMLoader<VMRecipe>(
        builder: (context, bloc) => Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverPersistentHeader(delegate: _Header()),
              SliverList(
                delegate: SliverChildListDelegate([
                  TextBox(
                    hintText: "Name",
                  ),
                  VerticalSpacer(8),
                  TextBox(
                    hintText: "Description",
                  ),
                  VerticalSpacer(8),
                  TextBox(),
                  VerticalSpacer(8),
                  TextBox(),
                ]),
              ),
            ],
          ),
        ),
      );
}

class _Header extends SliverPersistentHeaderDelegate {
  final double size = 80;
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
              onPressed: () {},
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
