import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  final TextEditingController controller;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final String hintText;
  final Function(String value) onChanged;

  TextBox({
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          shape: BoxShape.rectangle,
          color: Theme.of(context).accentColor,
        ),
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: TextField(
          style: TextStyle(
            fontSize: 20,
          ),
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            focusColor: Color(0xFF101010),
            prefixIcon: prefixIcon,
            border: InputBorder.none,
          ),
        ),
      );
}
