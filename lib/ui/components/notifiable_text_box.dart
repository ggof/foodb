import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foodb/ui/components/text_box.dart';
import 'package:foodb/ui/helpers/text_value.dart';

class NotifiableTextBox extends StatelessWidget {
  final Widget prefixIcon;
  final Widget suffixIcon;
  final String hintText;
  final TextInputType keyboardType;
  final int lines;
  final Function(String value) onChanged;
  final ValueListenable<TextValue> listenable;

  NotifiableTextBox({
    this.hintText,
    this.keyboardType,
    @required this.listenable,
    this.lines = 1,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
  });
  @override
  Widget build(BuildContext context) => ValueListenableBuilder<TextValue>(
        valueListenable: listenable,
        builder: (context, value, _) {
          return TextBox(
            error: value.error,
            hintText: hintText,
            keyboardType: keyboardType,
            lines: lines,
            onChanged: onChanged,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
          );
        },
      );
}
