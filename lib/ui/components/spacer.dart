import 'package:flutter/material.dart';

class VerticalSpacer extends StatelessWidget {
  final double size;

  const VerticalSpacer(this.size, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Padding(padding: EdgeInsets.only(top: size));
}

class HorizontalSpacer extends StatelessWidget {
  final double size;

  const HorizontalSpacer(this.size, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Padding(padding: EdgeInsets.only(left: size));
}
