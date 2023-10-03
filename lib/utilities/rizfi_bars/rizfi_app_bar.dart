import 'package:flutter/material.dart';

import '../buttons/my_dropdown_button.dart';
import '../decorators.dart';

class RizfiAppBar extends StatelessWidget {
  const RizfiAppBar({
    Key? key,
    this.barTitleString = 'Bar Title',
    this.emptyTitleBarString = 'Empty Title',
    this.barTitleSize = 20,
    this.leftTabIcon,
    this.rightTabIcon,
    this.leftTabTitle,
    this.rightTabTitle,
    this.leftTabSubtitle,
    this.rightTabSubtitle,
    this.iconSize = 20,
    this.titleFontSize = 12,
    this.subTitleFontSize = 10,
    this.leftDropdownItems,
    this.rightDropdownItems,
    this.barTitleColor = MyColors.c2,
    this.tabColor = Colors.transparent,
    this.borderColor,
    this.tabHoverColor = MyColors.c2,
    this.majorColor = MyColors.c2,
    this.leftToolTip = '',
    this.rightToolTip = '',
    this.onLeftTap,
    this.onRightTap,
    this.dividerColor = MyColors.c2,
    this.bodyWidget,
  }) : super(key: key);
  final IconData? leftTabIcon, rightTabIcon;
  final String barTitleString, emptyTitleBarString, leftToolTip, rightToolTip;
  final String? leftTabTitle, rightTabTitle, leftTabSubtitle, rightTabSubtitle;
  final double barTitleSize, iconSize, titleFontSize, subTitleFontSize;
  final List<MyDropdownMenuItem>? leftDropdownItems, rightDropdownItems;
  final Color barTitleColor, tabColor, tabHoverColor, majorColor, dividerColor;
  final Function? onLeftTap, onRightTap;
  final Color? borderColor;
  final Widget? bodyWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 70,
              height: 70,
              child: (onLeftTap == null || barTitleString == '')
                  ? null
                  : leftDropdownItems == null
                      ? _rizfiSimpleTab(true)
                      : _rizfiDropdownTab(context, true),
            ),
            Expanded(
              child: Text(
                  barTitleString == '' ? emptyTitleBarString : barTitleString,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: barTitleSize,
                      fontWeight: FontWeight.bold,
                      color: barTitleColor)),
            ),
            SizedBox(
              width: 70,
              height: 70,
              child: (onRightTap == null || barTitleString == '')
                  ? null
                  : rightDropdownItems == null
                      ? _rizfiSimpleTab(false)
                      : _rizfiDropdownTab(context, false),
            ),
          ],
        ),
        Divider(height: 4, thickness: 1.0, color: dividerColor),
        if (bodyWidget != null) bodyWidget!,
      ],
    );
  }

  Widget _rizfiSimpleTab(bool leftOrRight) {
    return Tooltip(
      margin: const EdgeInsets.only(top: 8.0),
      message: leftOrRight ? leftToolTip : rightToolTip,
      child: InkWell(
          borderRadius: BorderRadius.circular(4.0),
          onTap: () => leftOrRight ? onLeftTap!() : onRightTap!(),
          hoverColor: tabHoverColor.withOpacity(0.1),
          child: leftOrRight
              ? _rizfiTabLayout(leftTabIcon, leftTabTitle, leftTabSubtitle)
              : _rizfiTabLayout(rightTabIcon, rightTabTitle, rightTabSubtitle)),
    );
  }

  Widget _rizfiDropdownTab(BuildContext context, bool leftOrRight) {
    return MyDropdownButton(
      tooltip: leftOrRight ? leftToolTip : rightToolTip,
      leftRightDirection: leftOrRight,
      majorColor: majorColor,
      tabHoverColor: tabHoverColor,
      rizfiButtonDropdownItems:
          (leftOrRight ? leftDropdownItems : rightDropdownItems),
      customButton: leftOrRight
          ? _rizfiTabLayout(leftTabIcon, leftTabTitle, leftTabSubtitle)
          : _rizfiTabLayout(rightTabIcon, rightTabTitle, rightTabSubtitle),
      onChanged: (text, icon) {
        leftOrRight ? onLeftTap!(text, icon) : onRightTap!(text, icon);
      },
    );
  }

  Widget _rizfiTabLayout(IconData? icon, String? title, String? subtitle) {
    return myCustomDropdownButton(
        tabColor: tabColor,
        borderColor: borderColor,
        majorColor: Colors.white,
        icon: icon,
        iconSize: iconSize,
        title: title,
        titleSize: titleFontSize,
        subtitle: subtitle,
        subtitleSize: subTitleFontSize);
  }
}
