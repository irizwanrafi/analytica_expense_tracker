import 'package:flutter/material.dart';

class RizfiScrollBars extends StatelessWidget {
  const RizfiScrollBars(
      {Key? key,
      this.minWidth = 300,
      this.minHeight = 350,
      required this.child})
      : super(key: key);
  final double? minWidth, minHeight;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ScrollController verticalController = ScrollController();
    final ScrollController horizontalController = ScrollController();
    return LayoutBuilder(builder: (bContext, constraints) {
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
                    width: minWidth! > constraints.maxWidth
                        ? minWidth
                        : constraints.maxWidth,
                    height: minHeight! > constraints.maxHeight
                        ? minHeight
                        : constraints.maxHeight,
                    child: child)),
          ),
        ),
      );
    });
  }
}
