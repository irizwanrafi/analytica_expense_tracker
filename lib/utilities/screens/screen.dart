import 'package:analytica_expense_tracker/utilities/buttons/my_dropdown_button.dart';
import 'package:analytica_expense_tracker/utilities/rizfi_bars/rizfi_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../view/intro/intro_screen.dart';
import '../decorators.dart';
import '../functions.dart';
import 'custom_screen_behavior.dart';

class MyScreen extends StatelessWidget {
  const MyScreen(
      {Key? key,
      required this.headerColor,
      required this.title,
      this.scaffoldKey,
      this.bodyWidget,
      this.bottomWidget,
      this.onLeftTap})
      : super(key: key);
  final Color headerColor;
  final String title;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final Widget? bodyWidget, bottomWidget;
  final Function? onLeftTap;

  @override
  Widget build(BuildContext context) {
    return MyCustomScreenBehavior(
      child: SafeArea(
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: MyColors.c5,
          body: Stack(
            children: [
              ClipPath(
                clipper: ShapeClipper(),
                child: Container(
                  height:
                      (rfIsMinHeight(context) ? rfMinHeight : context.height) *
                          (context.isLandscape ? 0.275 : 0.25),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [headerColor, headerColor.withOpacity(0.75)],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(0.0, 1.0),
                        stops: const [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                ),
              ),
              RizfiAppBar(
                dividerColor: Colors.transparent,
                barTitleColor: Colors.white,
                barTitleString: title,
                leftTabIcon: Icons.more_vert_rounded,
                iconSize: 25,
                majorColor: MyColors.c6,
                leftDropdownItems: title == 'Expenses'
                    ? [const MyDropdownMenuItem(text: 'Add Expense')]
                    : [
                        const MyDropdownMenuItem(text: 'Daily'),
                        const MyDropdownMenuItem(text: 'Monthly'),
                        const MyDropdownMenuItem(text: 'Yearly'),
                      ],
                onLeftTap: (text, icon) {
                  if (onLeftTap != null) onLeftTap!(text);
                },
                rightTabIcon: Icons.logout,
                onRightTap: () async {
                  ParseUser currentUser = await ParseUser.currentUser();
                  await currentUser.logout();
                  if (context.mounted) {
                    Navigator.pop(context);
                    Get.offAll(() => const MyIntroScreen());
                  }
                },
                bodyWidget: Expanded(
                  child: Column(
                    children: [
                      if (bodyWidget != null) Expanded(child: bodyWidget!),
                      if (bottomWidget != null) bottomWidget!,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _title(String title) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }
}

class ShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0.0, size.height * 0.5);
    path.quadraticBezierTo(
        size.width * 0.5, size.height * 1.5, size.width, size.height * 0.5);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
