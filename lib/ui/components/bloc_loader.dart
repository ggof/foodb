import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodb/locator.dart';
import 'package:foodb/ui/vm/vm.dart';

typedef VoidCallback<T extends VM> = void Function(T bloc);
typedef BuilderFunc<T extends VM> = Widget Function(BuildContext context, T vm);

class VMLoader<T extends VM> extends StatefulWidget {
  final VoidCallback<T> onVMReady;
  final BuilderFunc<T> builder;

  const VMLoader({
    @required this.builder,
    this.onVMReady,
  }) : assert(builder != null);

  @override
  State<VMLoader<T>> createState() => VMLoaderState<T>();
}

class VMLoaderState<T extends VM> extends State<VMLoader<T>> {
  final T bloc;

  VMLoaderState() : bloc = locator();

  @override
  void initState() {
    super.initState();
    if (widget.onVMReady != null) {
      widget.onVMReady(bloc);
    }
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, bloc);
}
