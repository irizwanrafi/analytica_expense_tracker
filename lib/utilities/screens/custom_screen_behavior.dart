import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../functions.dart';

class MyCustomScreenBehavior extends StatelessWidget {
  const MyCustomScreenBehavior(
      {Key? key, this.minWidth, this.minHeight, required this.child})
      : super(key: key);
  final double? minWidth, minHeight;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ScrollController verticalController = ScrollController();
    final ScrollController horizontalController = ScrollController();
    return Scrollbar(
      thumbVisibility: true,
      controller: verticalController,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        controller: verticalController,
        child: Scrollbar(
          thumbVisibility: true,
          controller: horizontalController,
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: horizontalController,
              child: SizedBox(
                  width: rfIsMinWidth(context)
                      ? rfMinWidth
                      : minWidth ?? context.width,
                  height: rfIsMinHeight(context)
                      ? rfMinHeight
                      : minHeight ?? context.height,
                  child: child)),
        ),
      ),
    );
  }
}
