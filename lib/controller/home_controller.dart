import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../api/home/apis.dart';
import '../model/home_model.dart';

class MyHomeController extends GetxController {
  //declaration
  final List<String> _categories = [
    'Food',
    'Transport',
    'Entertainment',
    'Sports',
    'Utilities'
  ];
  final MyHomeApis _callApi = MyHomeApis();
  int _currentPage = 0;
  final _loading = false.obs;
  final List<MyExpenseModel> _expenses = [];
  final _pageController = PageController(initialPage: 0);
  final _pageTitle = 'Expenses'.obs;

  @override
  void onInit() {
    _loadExpenses();
    super.onInit();
  }

  //getters
  List<String> get categories => _categories;
  bool get loading => _loading.value;
  List<MyExpenseModel> get expenses => _expenses;
  get pageController => _pageController;
  String get pageTitle => _pageTitle.value;
  get currentPage => _currentPage;
  List<MyPageModel> get pages => _pages;

  //functions
  navigateToPage(int index) {
    _currentPage = index;
    _pageTitle.value = _pages[_currentPage].title;
    pageController.animateToPage(index,
        duration: 500.milliseconds, curve: Curves.linear);
  }

  ///Pages
  final _pages = <MyPageModel>[
    MyPageModel(title: 'Expenses', iconData: Icons.payments),
    MyPageModel(title: 'Dashboard', iconData: Icons.bar_chart)
  ];

  ///Load Expenses Data from server
  void _loadExpenses() async {
    _loading.value = true;
    _expenses.addAll(await _callApi.loadExpenses());
    _loading.value = false;
  }

  ///Add New Expense
  Future<ParseError?> addNewExpense(MyExpenseModel model, File? file) async {
    ParseError? error;
    _loading.value = true;
    dynamic response = await _callApi.createExpense(model, file);
    response.runtimeType == ParseError
        ? error = response
        : _expenses.insert(0, response);
    _loading.value = false;
    return error;
  }

  ///Update Expense
  Future<ParseError?> updateExpense(
      int index, MyExpenseModel model, File? file) async {
    ParseError? error;
    _loading.value = true;
    dynamic response =
        await _callApi.updateExpense(_expenses[index].objectId, model, file);
    response.runtimeType == ParseError
        ? error = response
        : _expenses[index] = response;
    _loading.value = false;
    return error;
  }

  ///Delete Expense
  Future<ParseError?> deleteExpense(int index) async {
    _loading.value = true;
    ParseError? error = await _callApi.deleteExpense(_expenses[index].objectId);
    if (error == null) _expenses.removeAt(index);
    _loading.value = false;
    return error;
  }
}
