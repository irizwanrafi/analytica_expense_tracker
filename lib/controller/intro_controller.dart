import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../api/intro/apis.dart';
import '../model/intro_model.dart';
import '../utilities/dialogs/error_dialog.dart';
import '../utilities/dialogs/loading_dialog.dart';
import '../view/home/screen.dart';

class IntroController extends GetxController {
  //declaration
  final MyIntroApis _callApi = MyIntroApis();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController _pageController = PageController(initialPage: 0);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _currentPage = 0.obs, _isObscure = true.obs;
  final List<IntroPageModel> _pages = [
    IntroPageModel(
      logoString: 'assets/images/developer.jpg',
      titleString: 'AET',
      descriptionString: 'Developed by Rizwan Rafi',
    ),
    IntroPageModel(
      logoString: 'assets/images/analytica.jpg',
      titleString: 'Analytica',
      descriptionString: 'Innovative Solutions Designed for Success',
    ),
    IntroPageModel(
      logoString: '',
      titleString: 'Login',
      descriptionString: 'Enter username & password.',
      isLoginPage: true,
    ),
  ];

  //Getters
  get getScaffoldKey => _scaffoldKey;
  get pageController => _pageController;
  get getFormKey => _formKey;
  get getIsObscure => _isObscure.value;
  get getIntroPages => _pages;

  //functions
  setIsObscure() => _isObscure.value = !_isObscure.value;
  IconData getIcon(bool isLandscape) {
    return (_currentPage.value < (_pages.length - 1))
        ? (isLandscape)
            ? Icons.keyboard_arrow_down
            : Icons.keyboard_arrow_right
        : Icons.start;
  }

  //Registration
  Future<ParseError?> userRegistration(UserRegistrationModel model) =>
      _callApi.userRegistration(model);

  //forward act
  String _username = '', _password = '';
  set setUsername(value) => _username = value;
  set setPassword(value) => _password = value;
  void forwardAct(BuildContext context) async {
    if (_currentPage.value == (_pages.length - 1)) {
      if (_formKey.currentState!.validate()) {
        showMyLoadingDialog(context);
        ParseError? error = await _callApi.userLogin(_username, _password);
        if (context.mounted) {
          Navigator.pop(context);
          error == null
              ? Get.to(() => const MyHomeScreen())
              : showMyParseErrorDialog(context, error);
        }
      }
    } else {
      _currentPage.value++;
      _pageController.animateToPage(_currentPage.value,
          duration: 500.milliseconds, curve: Curves.linear);
    }
  }
}
