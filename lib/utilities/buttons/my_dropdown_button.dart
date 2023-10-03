import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../decorators.dart';

class MyDropdownButton extends StatelessWidget {
  const MyDropdownButton({
    super.key,
    required this.customButton,
    this.tooltip,
    this.leftRightDirection,
    this.majorColor,
    this.tabHoverColor,
    this.rizfiButtonDropdownItems,
    required this.onChanged,
  });
  final Widget customButton;
  final String? tooltip;
  final bool? leftRightDirection;
  final Color? majorColor, tabHoverColor;
  final List<MyDropdownMenuItem>? rizfiButtonDropdownItems;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      margin: const EdgeInsets.only(top: 8.0),
      message: tooltip,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          dropdownStyleData: DropdownStyleData(
            direction: (leftRightDirection == null || !leftRightDirection!)
                ? DropdownDirection.left
                : DropdownDirection.right,
            offset: Offset(
                (leftRightDirection == null || !leftRightDirection!) ? -16 : 16,
                8),
            elevation: 8,
            width: 200,
            decoration: BoxDecoration(
                color: majorColor, borderRadius: BorderRadius.circular(4.0)),
          ),
          customButton: customButton,
          items: [
            ...rizfiButtonDropdownItems!.map(
              (item) => DropdownMenuItem<MyDropdownMenuItem>(
                value: item,
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      item.text,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white),
                    )),
                    const SizedBox(width: 10),
                    if (item.icon != null)
                      Icon(item.icon, color: Colors.white, size: 22),
                    if (item.numberToShow != null && item.numberToShow != 0)
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.white.withOpacity(0.9),
                        child: Text('${item.numberToShow}',
                            style: const TextStyle(
                                color: MyColors.c2,
                                fontWeight: FontWeight.bold)),
                      ),
                  ],
                ),
              ),
            ),
          ],
          buttonStyleData: ButtonStyleData(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(4.0)),
              overlayColor: MaterialStateProperty.all(tabHoverColor != null
                  ? tabHoverColor!.withOpacity(0.1)
                  : null)),
          onMenuStateChange: (value) {
            // FocusScope.of(context).requestFocus(FocusNode());
          },
          onChanged: (value) {
            MyDropdownMenuItem menuItem = value as MyDropdownMenuItem;
            onChanged(menuItem.text, menuItem.icon);
          },
        ),
      ),
    );
  }
}

class MyDropdownMenuItem {
  final String text;
  final IconData? icon;
  final int? numberToShow;
  const MyDropdownMenuItem({required this.text, this.icon, this.numberToShow});
}

Widget myCustomDropdownButton({
  Color? tabColor,
  Color? borderColor,
  IconData? icon,
  double? iconSize,
  String? title,
  double? titleSize,
  String? subtitle,
  double? subtitleSize,
  Color? majorColor,
}) {
  return DecoratedBox(
    decoration: BoxDecoration(
      color: tabColor,
      border: borderColor == null
          ? null
          : Border.all(width: 1.0, color: borderColor),
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Icon(
              icon,
              size: iconSize,
              color: majorColor,
            ),
          if (title != null)
            Text(title,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: titleSize,
                  color: majorColor,
                )),
          if (subtitle != null)
            Text(subtitle,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: subtitleSize,
                  color: majorColor,
                )),
        ],
      ),
    ),
  );
}
