import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodb/core/entities/recipe.dart';
import 'package:foodb/ui/components/card_recipe.dart';
import 'package:foodb/ui/components/text_box.dart';
import 'package:foodb/ui/components/vm_loader.dart';
import 'package:foodb/ui/vm/vm.dart';
import 'package:foodb/ui/vm/vm_recipe_list.dart';

class PageRecipeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) => VMLoader<VMRecipeList>(
        (context, vm) => Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed("/recipes/add");
            },
          ),
          body: SafeArea(
            child: ValueListenableBuilder<ViewState>(
                valueListenable: vm.state,
                builder: (context, state, _) {
                  if (state is Busy) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: vm.refresh,
                    child: CustomScrollView(
                      slivers: [
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                        SliverAppBar(
                          automaticallyImplyLeading: false,
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          title: TextBox(
                            prefixIcon: Icon(Icons.search_rounded),
                            hintText: "Search something ...",
                            onChanged: vm.setFilter,
                            showTitle: false,
                          ),
                        ),
                        ValueListenableBuilder<Iterable<Recipe>>(
                          valueListenable: vm.list,
                          builder: (context, list, _) => SliverList(
                            delegate: SliverChildListDelegate(
                              list.map(toCard(context, vm)).toList(),
                            ),
                          ),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ),
        onVMReady: (vm) => vm.init(),
      );

  Widget Function(Recipe) toCard(BuildContext context, VMRecipeList vm) =>
      (Recipe t) => CardRecipe(
            t,
            onPressed: () => Navigator.of(context)
                .pushNamed("/recipes/single", arguments: {"id": t.id}),
            onLongPress: () async {
              final shouldDelete = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Delete \"${t.name}\""),
                  content: Text("Are you sure you want to delete this item?"),
                  actions: [
                    MaterialButton(
                      child: Text("yes"),
                      onPressed: () => Navigator.of(context).pop(true),
                    ),
                    MaterialButton(
                      child: Text("no"),
                      onPressed: () => Navigator.of(context).pop(false),
                    ),
                  ],
                ),
              );

              if (shouldDelete ?? false) {
                vm.onDelete(t);
              }
            },
          );
}
