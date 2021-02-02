import 'package:flutter/material.dart';
import 'package:foodb/ui/components/bloc_loader.dart';
import 'package:foodb/ui/components/spacer.dart';
import 'package:foodb/ui/components/text_box.dart';
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
              Form(
                child: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      ValueListenableBuilder<String>(
                        valueListenable: vm.name,
                        builder: (context, value, _) {
                          final selection = TextSelection.collapsed(
                              offset: value?.length ?? 0);
                          nameController.value = TextEditingValue(
                            text: value ?? "",
                            selection: selection,
                          );
                          return TextBox(
                            controller: nameController,
                            hintText: "Name",
                            onChanged: vm.setName,
                            validator: (name) =>
                                name.isEmpty ? "name must not be empty" : null,
                          );
                        },
                      ),
                      VerticalSpacer(8),
                      ValueListenableBuilder<String>(
                        valueListenable: vm.description,
                        builder: (context, value, _) {
                          final selection = TextSelection.collapsed(
                              offset: value?.length ?? 0);
                          descController.value = TextEditingValue(
                            text: value ?? "",
                            selection: selection,
                          );

                          return TextBox(
                            lines: 8,
                            controller: descController,
                            onChanged: vm.setDesc,
                            hintText: "Description",
                          );
                        },
                      ),
                      ValueListenableBuilder<List<String>>(
                        valueListenable: vm.errors,
                        builder: (context, errors, _) => Column(
                          children: [
                            for (final e in errors)
                              Text(
                                e,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3
                                    .copyWith(
                                      color: Color(0xFFFF0000),
                                    ),
                              ),
                          ],
                        ),
                      )
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
