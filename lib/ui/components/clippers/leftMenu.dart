/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';

class ClipperLeftMenu extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width-80, 0);
    path.quadraticBezierTo(
        size.width, size.height / 4, size.width, size.height/2);
    path.quadraticBezierTo(
        size.width, size.height - (size.height / 4), size.width-80, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }

}