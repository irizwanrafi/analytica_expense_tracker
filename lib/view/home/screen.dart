library dashboard_view;

import 'dart:io';

import 'package:analytica_expense_tracker/model/home_model.dart';
import 'package:analytica_expense_tracker/utilities/dialogs/message_dialog.dart';
import 'package:analytica_expense_tracker/utilities/text_fields/my_button_tff.dart';
import 'package:analytica_expense_tracker/view/home/chart.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../controller/home_controller.dart';
import '../../utilities/buttons/my_attachment.dart';
import '../../utilities/constants.dart';
import '../../utilities/decorators.dart';
import '../../utilities/dialogs/date_picker_dialog.dart';
import '../../utilities/dialogs/error_dialog.dart';
import '../../utilities/dialogs/general_dialog.dart';
import '../../utilities/screens/screen.dart';
import '../../utilities/text_fields/my_dropdown_tff.dart';
import '../../utilities/text_fields/my_general_tff.dart';
import 'chart_data.dart';

part 'expense_dialog.dart';
part 'list.dart';

late MyHomeController _controller;

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  late ParseError? parseError;

  @override
  void initState() {
    _controller = Get.put(MyHomeController());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<MyHomeController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => MyScreen(
          headerColor: MyColors.c2,
          onLeftTap: (String text) {
            if (text == 'Add Expense') {
              _addExpense(context);
            }
          },
          title: _controller.pageTitle,
          bodyWidget: Obx(() => PageView(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                controller: _controller.pageController,
                children: [
                  _myCard(_controller.loading
                      ? _circularIndicator()
                      : _Expenses(expenses: _controller.expenses)),
                  _myCard(MyChart(titles: const ['Expense'], data: data())),
                ],
              )),
          bottomWidget: CurvedNavigationBar(
            color: MyColors.c2,
            backgroundColor: MyColors.c5,
            buttonBackgroundColor: MyColors.c6,
            animationDuration: const Duration(milliseconds: 500),
            index: _controller.currentPage,
            items: List.generate(
              _controller.pages.length,
              (index) => Icon(
                _controller.pages[index].iconData,
                color: MyColors.c7,
              ),
            ),
            onTap: (index) => _controller.navigateToPage(index),
          ),
        ));
  }

  Widget _myCard(Widget myWidget) {
    return Card(
      margin: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.white.withOpacity(0.95),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: myWidget,
      ),
    );
  }

  Widget _circularIndicator() {
    return const Center(
        child: CircularProgressIndicator(
      color: MyColors.c6,
    ));
  }
}
