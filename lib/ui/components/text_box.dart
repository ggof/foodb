import 'package:flutter/material.dart';

class TextBox extends StatefulWidget {
  final String? initialValue;
  final String? error;
  final int? lines;
  final String hintText;
  final void Function(String value)? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool showTitle;

  TextBox({
    this.initialValue,
    this.error,
    this.hintText = "",
    this.keyboardType,
    this.lines = 1,
    this.onChanged,
    this.prefixIcon,
    this.showTitle = true,
    this.suffixIcon,
  });

  @override
  _TextBoxState createState() => _TextBoxState(this.initialValue);
}

class _TextBoxState extends State<TextBox> {
  final TextEditingController controller;

  _TextBoxState(String? initialValue): controller = TextEditingController(text: initialValue);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          if (widget.showTitle)
            Container(
              padding: const EdgeInsets.only(left: 8, bottom: 4),
              alignment: Alignment.centerLeft,
              child:
                  Text(widget.hintText , style: Theme.of(context).textTheme.headline3),
            ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              shape: BoxShape.rectangle,
              color: Theme.of(context).colorScheme.secondary,
            ),
            margin: const EdgeInsets.all(4),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextField(
              controller: controller,
              style: TextStyle(
                fontSize: 20,
              ),
              onChanged: widget.onChanged,
              maxLines: widget.lines,
              minLines: widget.lines,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: widget.hintText,
                focusColor: Color(0xFF101010),
                prefixIcon: widget.prefixIcon,
                border: InputBorder.none,
              ),
              keyboardType: widget.keyboardType,
            ),
          ),
          AnimatedContainer(
            padding: const EdgeInsets.only(left: 16),
            alignment: Alignment.centerLeft,
            child: Text(
              widget.error ?? "",
              style: TextStyle(
                color: Color(0xbbff6666),
              ),
            ),
            height: widget.error == null || (widget.error ?? "").isEmpty ? 0 : 32,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          )
        ],
      );

  String? noop(String _) => null;
}
