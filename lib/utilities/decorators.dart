import 'package:flutter/material.dart';

class MyColors {
  static const Color myBlueShade1 = Color(0xff293241);
  static const Color c2 = Color(0xff3d5a80);
  static const Color c3 = Color(0xff98c1d9);
  static const Color c4 = Color(0xbbdefbff);
  static const Color c5 = Color(0xffe0fbfc);
  static const Color c6 = Color(0xffee6c4d);
  static const Color c61 = Color(0xffb148d2);
  static const Color c62 = Color(0xffe79aff);
  static const Color c63 = Color(0xffccffcc);
  static const Color c64 = Color(0xff691883);
  static const Color c7 = Colors.white;
  static Color c8 = Colors.green.shade700;
  static Color c9 = Colors.red.shade700;
  static Color c10 = Colors.blue.shade700;
}

BoxDecoration logoBoxDecoration = BoxDecoration(
  color: MyColors.c2,
  border: Border.all(color: MyColors.myBlueShade1, width: 1.5),
  borderRadius: const BorderRadius.all(
    Radius.circular(30.0),
  ),
);
