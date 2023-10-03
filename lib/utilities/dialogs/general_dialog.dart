import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../buttons/my_simple_button.dart';
import '../decorators.dart';

class MyGeneralDialog extends StatelessWidget {
  const MyGeneralDialog(
      {Key? key,
      this.width = 300,
      this.height,
      this.title = 'General Title',
      this.greenText = 'Ok',
      this.redText = 'Cancel',
      this.blueText = 'Additional',
      this.bodyWidget,
      this.onGreenTap,
      this.onRedTap,
      this.onBlueTap})
      : super(key: key);

  final double? width, height;
  final String? title, greenText, redText, blueText;
  final Widget? bodyWidget;
  final VoidCallback? onGreenTap, onRedTap, onBlueTap;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      key: key,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: width,
              height: height,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title!,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: MyColors.c2),
                    ),
                  ),
                  const Divider(color: MyColors.myBlueShade1, height: 0),
                  if (bodyWidget != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: bodyWidget!,
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      if (context.isLandscape && onBlueTap == null)
                        const Expanded(child: SizedBox.shrink()),
                      if (onGreenTap == null || onRedTap == null)
                        const Expanded(child: SizedBox.shrink()),
                      if (onRedTap != null)
                        Expanded(
                          child: MySimpleButton(
                              title: redText!,
                              buttonColor: MyColors.c9,
                              onTap: () => onRedTap!()),
                        ),
                      if (onGreenTap != null) const SizedBox(width: 8),
                      if (onGreenTap != null)
                        Expanded(
                          child: MySimpleButton(
                              title: greenText!,
                              buttonColor: MyColors.c8,
                              onTap: () => onGreenTap!()),
                        ),
                      if (onBlueTap != null) const SizedBox(width: 8),
                      if (onBlueTap != null)
                        Expanded(
                          child: MySimpleButton(
                              title: blueText!,
                              buttonColor: MyColors.c10,
                              onTap: () => onBlueTap!()),
                        ),
                    ]),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
