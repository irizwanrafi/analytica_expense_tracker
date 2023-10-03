import 'package:flutter/material.dart';

import '../decorators.dart';

class MySimpleButton extends StatelessWidget {
  const MySimpleButton({
    Key? key,
    this.iconData,
    this.title,
    this.subtitle,
    this.boldTitle = false,
    this.toolTipMessage = '',
    this.buttonColor = MyColors.c6,
    this.contentColor = Colors.white,
    this.onTap,
  }) : super(key: key);

  final IconData? iconData;
  final String? title, subtitle, toolTipMessage;
  final bool boldTitle;
  final Color? buttonColor, contentColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      hoverColor: Colors.black87,
      focusColor: Colors.black87,
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Tooltip(
        message: toolTipMessage,
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: buttonColor == Colors.transparent
                  ? Colors.transparent
                  : buttonColor!.withOpacity(0.9),
              borderRadius: BorderRadius.circular(4.0)),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (iconData != null)
                  Icon(
                    iconData,
                    size: 20,
                    color: contentColor,
                  ),
                if (title != null)
                  Text(title!,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: contentColor,
                        fontWeight: boldTitle ? FontWeight.bold : null,
                      )),
                if (subtitle != null)
                  Text(subtitle!,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 11, color: contentColor)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
