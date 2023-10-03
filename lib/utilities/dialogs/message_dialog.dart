import 'package:flutter/material.dart';

import '../buttons/my_simple_button.dart';
import '../decorators.dart';

class MyMessageDialog extends StatelessWidget {
  const MyMessageDialog(
      {Key? key,
      this.title = 'Message Title',
      this.message = 'Message Description',
      this.width = 300,
      this.height,
      this.greenText = 'Ok',
      this.redText = 'Cancel',
      this.blueText = 'Additional',
      this.onGreenTap,
      this.onRedTap,
      this.onBlueTap})
      : super(key: key);

  final String? title, message, greenText, redText, blueText;
  final double? width, height;
  final VoidCallback? onGreenTap, onRedTap, onBlueTap;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      key: key,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
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
                      color: MyColors.myBlueShade1),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, bottom: 32),
                child: Text(message!,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  if (onBlueTap == null)
                    const Expanded(child: SizedBox.shrink()),
                  if (onGreenTap == null || onRedTap == null)
                    const Expanded(child: SizedBox.shrink()),
                  if (onRedTap != null)
                    Expanded(
                      child: MySimpleButton(
                          title: redText!,
                          buttonColor: MyColors.c9,
                          onTap: () {
                            Navigator.of(context).pop();
                            onRedTap!();
                          }),
                    ),
                  if (onGreenTap != null) const SizedBox(width: 8),
                  if (onGreenTap != null)
                    Expanded(
                      child: MySimpleButton(
                          title: greenText!,
                          buttonColor: MyColors.c8,
                          onTap: () {
                            Navigator.of(context).pop();
                            onGreenTap!();
                          }),
                    ),
                  if (onBlueTap != null) const SizedBox(width: 8),
                  if (onBlueTap != null)
                    Expanded(
                      child: MySimpleButton(
                          title: blueText!,
                          buttonColor: MyColors.c10,
                          onTap: () {
                            Navigator.of(context).pop();
                            onBlueTap!();
                          }),
                    ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
