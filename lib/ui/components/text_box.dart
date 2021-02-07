import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  final TextEditingController controller;
  final String error;
  final int lines;
  final String hintText;
  final void Function(String value) onChanged;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final TextInputType keyboardType;
  final bool showTitle;

  TextBox({
    this.controller,
    this.error,
    this.hintText,
    this.keyboardType,
    this.lines = 1,
    this.onChanged,
    this.prefixIcon,
    this.showTitle = true,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) => Column(
        children: [
          if (showTitle)
            Container(
              padding: const EdgeInsets.only(left: 8, bottom: 4),
              alignment: Alignment.centerLeft,
              child:
                  Text(hintText, style: Theme.of(context).textTheme.headline3),
            ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              shape: BoxShape.rectangle,
              color: Theme.of(context).accentColor,
            ),
            margin: const EdgeInsets.all(4),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextField(
              controller: controller,
              style: TextStyle(
                fontSize: 20,
              ),
              onChanged: onChanged,
              maxLines: lines,
              minLines: lines,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: hintText,
                focusColor: Color(0xFF101010),
                prefixIcon: prefixIcon,
                border: InputBorder.none,
              ),
              keyboardType: keyboardType,
            ),
          ),
          AnimatedContainer(
            padding: const EdgeInsets.only(left: 16),
            alignment: Alignment.centerLeft,
            child: Text(
              error ?? "",
              style: TextStyle(
                color: Color(0xbbff6666),
              ),
            ),
            height: error == null || error.isEmpty ? 0 : 32,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          )
        ],
      );

  String noop(String _) => null;
}
