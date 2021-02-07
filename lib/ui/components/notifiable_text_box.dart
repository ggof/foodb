import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foodb/ui/components/text_box.dart';
import 'package:foodb/ui/helpers/text_value.dart';

class NotifiableTextBox extends StatefulWidget {
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
  _NotifiableTextBoxState createState() => _NotifiableTextBoxState();
}

class _NotifiableTextBoxState extends State<NotifiableTextBox> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<TextValue>(
        valueListenable: widget.listenable,
        builder: (context, value, _) {
          controller.text = value.value;
          controller.value = TextEditingValue(
            text: value.value ?? "",
            selection: TextSelection.collapsed(offset: value?.value?.length ?? 0),
          );

          return TextBox(
            controller: controller,
            error: value.error,
            hintText: widget.hintText,
            keyboardType: widget.keyboardType,
            lines: widget.lines,
            onChanged: widget.onChanged,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
          );
        },
      );
}
