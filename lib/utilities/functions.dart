import 'package:flutter/material.dart';
import 'package:get/get.dart';

//Width and Height
//Screen
late double _minWidth, _minHeight;
void setPlatformMinSizes() {
  if (GetPlatform.isMobile || GetPlatform.isWeb) {
    _minWidth = 300;
    _minHeight = 300;
  } else {
    _minWidth = 400;
    _minHeight = 400;
  }
}

get rfMinWidth => _minWidth;
get rfMinHeight => _minHeight;
bool rfIsMinWidth(BuildContext context) => context.width < _minWidth;
bool rfIsMinHeight(BuildContext context) => context.height < _minHeight;

// String rfCommaSeparator(String string) {
//   RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
//   mathFunc(Match match) => '${match[1]},';
//   return string.replaceAllMapped(reg, mathFunc);
// }
//
//
// void kCustomStatusBarColor(Color color) {
//   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//     statusBarColor: color,
//     statusBarIconBrightness: Brightness.dark,
//   ));
// }
//
