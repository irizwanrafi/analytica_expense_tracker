import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../buttons/my_simple_button.dart';
import '../decorators.dart';
import '../rizfi_bars/rizfi_scrollbars.dart';
import '../rizfi_bars/rizfi_tab_bar.dart';

void showMyDatePickerDialog(
    {required BuildContext context,
    required Function onSelect,
    DateRangePickerView pickerView = DateRangePickerView.month,
    bool single = true,
    bool multiple = true,
    bool range = true,
    bool multiRange = true,
    bool time = true}) {
  showDialog(
    context: context,
    builder: (bContext) => _MyDatePickerDialog(
      pickerView: pickerView,
      single: single,
      range: range,
      multiple: multiple,
      multiRange: multiRange,
      time: time,
      onSelect: onSelect,
    ),
  );
}

class _MyDatePickerDialog extends StatefulWidget {
  const _MyDatePickerDialog({
    required this.pickerView,
    required this.single,
    required this.multiple,
    required this.range,
    required this.multiRange,
    required this.time,
    required this.onSelect,
  });
  final DateRangePickerView pickerView;
  final bool single, multiple, range, multiRange, time;
  final Function onSelect;

  @override
  State<_MyDatePickerDialog> createState() => _MyDatePickerDialogState();
}

class _MyDatePickerDialogState extends State<_MyDatePickerDialog> {
  late List<String> titles;
  late List<IconData> icons;
  late List<DateRangePickerSelectionMode> selectionModes;
  late PageController _pageController;
  late int _pageNumber;
  int? selectionModeIndex;
  DateRangePickerSelectionChangedArgs? args;

  @override
  void initState() {
    titles = [];
    icons = [];
    selectionModes = [];
    if (widget.single) {
      titles.add('Single');
      icons.add(Icons.event);
      selectionModes.add(DateRangePickerSelectionMode.single);
    }
    if (widget.multiple) {
      titles.add('Multiple');
      icons.add(Icons.calendar_month);
      selectionModes.add(DateRangePickerSelectionMode.multiple);
    }
    if (widget.range) {
      titles.add('Range');
      icons.add(Icons.date_range);
      selectionModes.add(DateRangePickerSelectionMode.range);
    }
    if (widget.multiRange) {
      titles.add('MultiRange');
      icons.add(Icons.event_note);
      selectionModes.add(DateRangePickerSelectionMode.multiRange);
    }
    if (widget.time) {
      titles.add('Time');
      icons.add(Icons.schedule);
    }
    _pageController = PageController();
    _pageNumber = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 400,
        height: 450,
        padding: const EdgeInsets.only(left: 8.0, top: 16.0, right: 8.0),
        child: RizfiScrollBars(
          child: RizfiTabBar(
            expandedTabs: true,
            selectedTab: _pageNumber,
            activeTabsColor: MyColors.c2.withOpacity(0.1),
            rizfiTabList: titles
                .map((title) => RizfiTab(
                    onTap: (int index) => _onTabClicked(index),
                    icon: icons[titles.indexOf(title)],
                    title: title))
                .toList(),
            bodyWidget: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      children: [
                        ...selectionModes.map((e) => _date(e)),
                        Container(color: Colors.pink),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Expanded(
                        child: MySimpleButton(
                          title: 'Cancel',
                          buttonColor: Colors.red,
                          onTap: () => Navigator.pop(context),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: MySimpleButton(
                          title: 'Select',
                          buttonColor: Colors.green,
                          onTap: () {
                            Navigator.pop(context);
                            widget.onSelect(selectionModeIndex, args);
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _onTabClicked(int index) {
    setState(() => _pageNumber = index);
    _pageController.animateToPage(index,
        duration: 500.milliseconds, curve: Curves.linear);
  }

  Widget _date(DateRangePickerSelectionMode selectionMode) {
    return SfDateRangePicker(
      view: widget.pickerView,
      selectionMode: selectionMode,
      onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
        if (args.value is DateTime) {
          selectionModeIndex = 0;
        } else if (args.value is List<DateTime>) {
          selectionModeIndex = 1;
        } else if (args.value is PickerDateRange) {
          selectionModeIndex = 2;
        } else {
          selectionModeIndex = 3;
        }
        this.args = args;
      },
    );
  }
}
