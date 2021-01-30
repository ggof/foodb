import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodb/core/domain/entities/recipe.dart';
import 'package:foodb/ui/components/bloc_loader.dart';
import 'package:foodb/ui/components/card_recipe.dart';
import 'package:foodb/ui/components/text_box.dart';
import 'package:foodb/ui/vm/vm_recipe_list.dart';

class PageRecipeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) => VMLoader<VMRecipeList>(
        onVMReady: (vm) => vm.init(),
        builder: (context, vm) => Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed("/recipes/add");
            },
          ),
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
                SliverAppBar(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  title: TextBox(
                    prefixIcon: Icon(Icons.search_rounded),
                    hintText: "Search something ...",
                    onChanged: vm.filterBy,
                  ),
                ),
                ValueListenableBuilder<List<Recipe>>(
                  valueListenable: vm.filtered,
                  builder: (context, list, _) => SliverList(
                    delegate: SliverChildListDelegate(
                      list.map(toCard(context)).toList(),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                ),
              ],
            ),
          ),
        ),
      );

  Widget Function(Recipe) toCard(BuildContext context) =>
      (Recipe t) => CardRecipe(
            recipe: t,
            onPressed: () => Navigator.of(context)
                .pushNamed("/recipes/single", arguments: {"id": t.id}),
          );
}
