library intro_view;

import 'package:analytica_expense_tracker/model/intro_model.dart';
import 'package:analytica_expense_tracker/utilities/dialogs/error_dialog.dart';
import 'package:analytica_expense_tracker/utilities/dialogs/loading_dialog.dart';
import 'package:analytica_expense_tracker/utilities/snackbars/message_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../controller/intro_controller.dart';
import '../../utilities/buttons/my_simple_button.dart';
import '../../utilities/constants.dart';
import '../../utilities/decorators.dart';
import '../../utilities/dialogs/general_dialog.dart';
import '../../utilities/functions.dart';
import '../../utilities/screens/custom_screen_behavior.dart';
import '../../utilities/text_fields/my_dropdown_tff.dart';
import '../../utilities/text_fields/my_general_tff.dart';
import '../home/screen.dart';

part 'page_body.dart';
part 'page_header.dart';
part 'text_form_field.dart';
part 'user_registration.dart';

late IntroController _introController;

class MyIntroScreen extends StatefulWidget {
  const MyIntroScreen({Key? key}) : super(key: key);

  @override
  State<MyIntroScreen> createState() => _MyIntroScreenState();
}

class _MyIntroScreenState extends State<MyIntroScreen> {
  @override
  void initState() {
    _introController = Get.put(IntroController());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<IntroController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyCustomScreenBehavior(
      child: Scaffold(
        backgroundColor: MyColors.c5,
        key: _introController.getScaffoldKey,
        body: SizedBox(
          width: rfIsMinWidth(context) ? rfMinWidth : context.width,
          height: rfIsMinHeight(context) ? rfMinHeight : context.height,
          child: PageView(
            scrollDirection:
                context.isLandscape ? Axis.vertical : Axis.horizontal,
            controller: _introController.pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              ..._introController.getIntroPages.map(
                (item) => context.isLandscape
                    ? Row(children: [
                        _MyPageHeader(logoString: item.logoString),
                        _MyPageBody(
                            titleStr: item.titleString,
                            descriptionStr: item.descriptionString,
                            isLoginPage: item.isLoginPage)
                      ])
                    : Column(children: [
                        _MyPageHeader(logoString: item.logoString),
                        _MyPageBody(
                            titleStr: item.titleString,
                            descriptionStr: item.descriptionString,
                            isLoginPage: item.isLoginPage)
                      ]),
              ),
            ],
          ),
        ),
        floatingActionButton: Obx(
          () => FloatingActionButton.small(
            onPressed: () => _introController
                .forwardAct(_introController.getScaffoldKey.currentContext),
            backgroundColor: MyColors.c6,
            child: Icon(_introController.getIcon(context.isLandscape)),
          ),
        ),
      ),
    );
  }
}
