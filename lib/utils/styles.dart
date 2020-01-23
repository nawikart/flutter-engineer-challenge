import 'package:flutter/material.dart';

class CustomTextStyle {
  static TextStyle smallLink(BuildContext context) {
    return TextStyle(
      decoration: TextDecoration.underline,
      fontSize: 13,
      color: Color(0xff6d7e8f),
      fontWeight: FontWeight.w200,
    );
  }

  static TextStyle errorText(BuildContext context) {
    return TextStyle(
      fontSize: 13,
      color: Colors.red,
      fontWeight: FontWeight.w200,
    );
  }
}
