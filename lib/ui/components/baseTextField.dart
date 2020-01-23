import 'package:flutter/material.dart';

class BaseTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextAlign textAlign;
  final int maxLines;
  final String initialValue;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool rounded;
  final Function onSaved;
  final Function onChanged;

  BaseTextField({
    this.labelText,
    this.hintText,
    this.textAlign,
    this.maxLines,
    this.initialValue,
    this.controller,
    this.keyboardType,
    this.obscureText,
    this.rounded,
    this.onSaved,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final border = (!(rounded ?? false))
        ? UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 0.5),
          )
        : OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: theme.accentColor, width: 2),
          );

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(labelText),
        ),
        TextFormField(
            maxLines: maxLines ?? 1,
            initialValue: initialValue,
            controller: controller,
            textAlign: textAlign ?? TextAlign.left,
            keyboardType: keyboardType,
            obscureText: obscureText ?? false,
            decoration: new InputDecoration(
                hintText: hintText,
                contentPadding: EdgeInsets.all(10),
                filled: (rounded ?? false) ? true : false,
                enabledBorder: border,
                focusedBorder: border),
            onSaved: onSaved,
            onChanged: onChanged),
      ],
    );
  }
}
