import 'package:flutter/material.dart';

class BaseTextField extends StatelessWidget {
  final String labelText;
  final TextAlign textAlign;
  final int maxLines;
  final String initialValue;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool rounded;

  BaseTextField(
      {this.labelText,
      this.textAlign,
      this.maxLines,
      this.initialValue,
      this.keyboardType,
      this.obscureText,
      this.rounded});

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
          initialValue: initialValue ?? '',
          style: (rounded ?? false) ? TextStyle(color: Colors.black) : null,
          textAlign: textAlign ?? TextAlign.left,
          keyboardType: keyboardType,
          obscureText: obscureText ?? false,
          decoration: new InputDecoration(
              contentPadding: EdgeInsets.all(10),
              fillColor: Colors.white,
              filled: (rounded ?? false) ? true : false,
              enabledBorder: border,
              focusedBorder: border),
        ),
      ],
    );
  }
}
