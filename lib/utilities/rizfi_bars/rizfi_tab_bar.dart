import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../decorators.dart';

enum MyTabsPlacement { top, bottom, left, right }

class RizfiTabBar extends StatelessWidget {
  const RizfiTabBar({
    Key? key,
    required this.rizfiTabList,
    required this.bodyWidget,
    this.tabsPlacement = MyTabsPlacement.top,
    this.tabSize = 70.0,
    this.selectedTab = -1,
    this.showDivider = true,
    this.showTabBoarder = false,
    this.expandedTabs = false,
    this.dividerColor = MyColors.c2,
    this.tabsBorderColor = MyColors.c6,
    this.tabsColor = Colors.transparent,
    this.tabsHoverColor = MyColors.c2,
    this.iconsColor = MyColors.c2,
    this.titlesColor = MyColors.c2,
    this.subtitlesColor = MyColors.c2,
    this.dropdownsMenuColor = MyColors.c2,
    this.dividerSize = 1.0,
    this.tabBorderSize = 2.0,
    this.iconsSize = 20,
    this.titlesFontSize = 12,
    this.subTitlesFontSize = 10,
    this.activeTabsBorderColor,
    this.passiveTabsBorderColor,
    this.activeTabsColor = MyColors.c6,
    this.passiveTabsColor,
    this.activeIconsColor,
    this.passiveIconsColor,
    this.activeTitlesColor,
    this.passiveTitlesColor,
    this.activeSubtitlesColor,
    this.passiveSubtitlesColor,
    this.activeIconsSize,
    this.passiveIconsSize,
    this.activeTitlesFontSize,
    this.passiveTitlesFontSize,
    this.activeSubtitlesFontSize,
    this.passiveSubtitlesFontSize,
  }) : super(key: key);

  final List<RizfiTab> rizfiTabList;
  final Widget bodyWidget;
  final MyTabsPlacement tabsPlacement;
  final int? selectedTab;
  final bool showTabBoarder, showDivider, expandedTabs;
  final Color? dividerColor,
      tabsBorderColor,
      tabsColor,
      tabsHoverColor,
      iconsColor,
      titlesColor,
      subtitlesColor,
      dropdownsMenuColor,
      activeTabsBorderColor,
      passiveTabsBorderColor,
      activeTabsColor,
      passiveTabsColor,
      activeIconsColor,
      passiveIconsColor,
      activeTitlesColor,
      passiveTitlesColor,
      activeSubtitlesColor,
      passiveSubtitlesColor;
  final double? tabSize,
      tabBorderSize,
      dividerSize,
      activeIconsSize,
      passiveIconsSize,
      iconsSize,
      activeTitlesFontSize,
      passiveTitlesFontSize,
      titlesFontSize,
      activeSubtitlesFontSize,
      passiveSubtitlesFontSize,
      subTitlesFontSize;

  @override
  Widget build(BuildContext context) {
    return _setRizfiPlacement(
      List.generate(
        rizfiTabList.length,
        (index) => expandedTabs
            ? Expanded(
                child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: SizedBox(
                  height: tabSize,
                  width: tabSize,
                  child: (rizfiTabList[index].myRizfiTabDropdownItems == null)
                      ? _rizfiSimpleTab(rizfiTabList[index], index)
                      : _rizfiDropdownTab(context, rizfiTabList[index], index),
                ),
              ))
            : SizedBox(
                height: tabSize,
                width: tabSize,
                child: (rizfiTabList[index].myRizfiTabDropdownItems == null)
                    ? _rizfiSimpleTab(rizfiTabList[index], index)
                    : _rizfiDropdownTab(context, rizfiTabList[index], index),
              ),
      ),
    );
  }

  Widget _setRizfiPlacement(List<Widget> tabsList) {
    if (tabsPlacement == MyTabsPlacement.top) {
      return Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: tabsList),
          if (showDivider)
            Divider(height: 4, thickness: dividerSize, color: dividerColor),
          Expanded(child: bodyWidget),
        ],
      );
    } else if (tabsPlacement == MyTabsPlacement.bottom) {
      return Column(
        children: [
          Expanded(child: bodyWidget),
          if (showDivider)
            Divider(height: 4, thickness: dividerSize, color: dividerColor),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: tabsList),
        ],
      );
    } else if (tabsPlacement == MyTabsPlacement.left) {
      return Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: tabsList,
          ),
          if (showDivider)
            VerticalDivider(
                width: 4, thickness: dividerSize, color: dividerColor),
          Expanded(child: bodyWidget),
        ],
      );
    } else {
      return Row(
        children: [
          Expanded(child: bodyWidget),
          if (showDivider)
            VerticalDivider(
                width: 4, thickness: dividerSize, color: dividerColor),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: tabsList,
          ),
        ],
      );
    }
  }

  Widget _rizfiSimpleTab(RizfiTab tab, int index) {
    return InkWell(
        borderRadius: BorderRadius.circular(4.0),
        onTap: () => selectedTab! < 0 ? tab.onTap() : tab.onTap(index),
        hoverColor: tab.hoverColor ?? tabsHoverColor!.withOpacity(0.1),
        child: _rizfiTabLayout(tab, selectedTab == index));
  }

  Widget _rizfiDropdownTab(BuildContext context, RizfiTab tab, int index) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        dropdownStyleData: DropdownStyleData(
          offset: const Offset(16, 8),
          elevation: 8,
          width: 200,
          decoration: BoxDecoration(
              color: tab.dropdownMenuColor ?? dropdownsMenuColor,
              borderRadius: BorderRadius.circular(4.0)),
        ),
        customButton: _rizfiTabLayout(tab, selectedTab == index),
        items: [
          ...tab.myRizfiTabDropdownItems!.map(
            (item) => DropdownMenuItem<MyRizfiTabDropdownItem>(
              value: item,
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    item.text,
                    style: const TextStyle(color: Colors.white),
                  )),
                  const SizedBox(width: 10),
                  Icon(item.icon, color: Colors.white, size: 22),
                ],
              ),
            ),
          ),
        ],
        buttonStyleData: ButtonStyleData(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0)),
            overlayColor: MaterialStateProperty.all(
                tab.hoverColor ?? tabsHoverColor!.withOpacity(0.1))),
        onMenuStateChange: (value) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        onChanged: (value) {
          MyRizfiTabDropdownItem menuItem = value as MyRizfiTabDropdownItem;
          tab.onTap(menuItem.text, menuItem.icon);
        },
      ),
    );
  }

  Widget _rizfiTabLayout(RizfiTab tab, bool activeOrPassive) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _selection(
            activeOrPassive: activeOrPassive,
            activeValue: tab.activeTabColor,
            passiveValue: tab.passiveTabColor,
            value: tab.tabColor,
            activesValue: activeTabsColor,
            passivesValue: passiveTabsColor,
            values: tabsColor),
        border: showTabBoarder
            ? Border.all(
                width: tabBorderSize!,
                color: _selection(
                    activeOrPassive: activeOrPassive,
                    activeValue: tab.activeTabBorderColor,
                    passiveValue: tab.passiveTabBorderColor,
                    value: tab.tabBorderColor,
                    activesValue: activeTabsBorderColor,
                    passivesValue: passiveTabsBorderColor,
                    values: tabsBorderColor)!)
            : null,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (tab.icon != null)
              Icon(tab.icon,
                  size: _selection(
                      activeOrPassive: activeOrPassive,
                      activeValue: tab.activeIconSize,
                      passiveValue: tab.passiveIconSize,
                      value: tab.iconSize,
                      activesValue: activeIconsSize,
                      passivesValue: passiveIconsSize,
                      values: iconsSize),
                  color: _selection(
                      activeOrPassive: activeOrPassive,
                      activeValue: tab.activeIconColor,
                      passiveValue: tab.passiveIconColor,
                      value: tab.iconColor,
                      activesValue: activeIconsColor,
                      passivesValue: passiveIconsColor,
                      values: iconsColor)),
            if (tab.title != null)
              Text(tab.title!,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: _selection(
                        activeOrPassive: activeOrPassive,
                        activeValue: tab.activeTitleFontSize,
                        passiveValue: tab.passiveTitleFontSize,
                        value: tab.titleFontSize,
                        activesValue: activeTitlesFontSize,
                        passivesValue: passiveTitlesFontSize,
                        values: titlesFontSize),
                    color: _selection(
                        activeOrPassive: activeOrPassive,
                        activeValue: tab.activeTitleColor,
                        passiveValue: tab.passiveTitleColor,
                        value: tab.titleColor,
                        activesValue: activeTitlesColor,
                        passivesValue: passiveTitlesColor,
                        values: titlesColor),
                  )),
            if (tab.subtitle != null)
              Text(tab.subtitle!,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: _selection(
                        activeOrPassive: activeOrPassive,
                        activeValue: tab.activeSubtitleFontSize,
                        passiveValue: tab.passiveSubtitleFontSize,
                        value: tab.subTitleFontSize,
                        activesValue: activeSubtitlesFontSize,
                        passivesValue: passiveSubtitlesFontSize,
                        values: subTitlesFontSize),
                    color: _selection(
                        activeOrPassive: activeOrPassive,
                        activeValue: tab.activeSubtitleColor,
                        passiveValue: tab.passiveSubtitleColor,
                        value: tab.subtitleColor,
                        activesValue: activeSubtitlesColor,
                        passivesValue: passiveSubtitlesColor,
                        values: subtitlesColor),
                  )),
          ],
        ),
      ),
    );
  }
}

dynamic _selection({
  dynamic activeOrPassive,
  dynamic activeValue,
  dynamic passiveValue,
  dynamic value,
  dynamic activesValue,
  dynamic passivesValue,
  dynamic values,
}) {
  dynamic returnValue;

  if (activeOrPassive == null || !activeOrPassive) {
    if (passiveValue != null) {
      returnValue = passiveValue;
    } else if (value != null) {
      returnValue = value;
    } else if (passivesValue != null) {
      returnValue = passivesValue;
    } else if (values != null) {
      returnValue = values;
    }
  } else {
    if (activeValue != null) {
      returnValue = activeValue;
    } else if (value != null) {
      returnValue = value;
    } else if (activesValue != null) {
      returnValue = activesValue;
    } else if (values != null) {
      returnValue = values;
    }
  }
  return returnValue;
}

class RizfiTab {
  RizfiTab({
    required this.onTap,
    this.title,
    this.subtitle,
    this.icon,
    this.tabBorderColor,
    this.tabColor,
    this.hoverColor,
    this.iconColor,
    this.titleColor,
    this.subtitleColor,
    this.dropdownMenuColor,
    this.iconSize,
    this.titleFontSize,
    this.subTitleFontSize,
    this.activeTabBorderColor,
    this.passiveTabBorderColor,
    this.activeTabColor,
    this.passiveTabColor,
    this.activeIconColor,
    this.passiveIconColor,
    this.activeTitleColor,
    this.passiveTitleColor,
    this.activeSubtitleColor,
    this.passiveSubtitleColor,
    this.activeIconSize,
    this.passiveIconSize,
    this.activeTitleFontSize,
    this.passiveTitleFontSize,
    this.activeSubtitleFontSize,
    this.passiveSubtitleFontSize,
    this.myRizfiTabDropdownItems,
  });
  final Function onTap;
  final String? title, subtitle;
  final IconData? icon;
  final Color? tabBorderColor,
      tabColor,
      hoverColor,
      iconColor,
      titleColor,
      subtitleColor,
      dropdownMenuColor,
      activeTabBorderColor,
      passiveTabBorderColor,
      activeTabColor,
      passiveTabColor,
      activeIconColor,
      passiveIconColor,
      activeTitleColor,
      passiveTitleColor,
      activeSubtitleColor,
      passiveSubtitleColor;
  final List<MyRizfiTabDropdownItem>? myRizfiTabDropdownItems;
  final double? activeIconSize,
      passiveIconSize,
      iconSize,
      activeTitleFontSize,
      passiveTitleFontSize,
      titleFontSize,
      activeSubtitleFontSize,
      passiveSubtitleFontSize,
      subTitleFontSize;
}

class MyRizfiTabDropdownItem {
  final String text;
  final IconData? icon;
  const MyRizfiTabDropdownItem({required this.text, this.icon});
}
