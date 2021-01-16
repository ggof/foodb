import 'package:flutter/material.dart';
import 'package:foodb/ui/components/bloc_loader.dart';

class PageRecipe extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: VMLoader(
          builder: (context, bloc) {},
        ),
      );
}
