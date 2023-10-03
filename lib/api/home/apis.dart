library dashboard_apis;

import 'dart:io';

import 'package:analytica_expense_tracker/model/home_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

part 'expenses/create.dart';
part 'expenses/delete.dart';
part 'expenses/load.dart';
part 'expenses/update.dart';

class MyHomeApis {
  Future<List<MyExpenseModel>> loadExpenses() async =>
      await _callFunction(_loadExpenses());

  Future<dynamic> createExpense(MyExpenseModel model, File? file) =>
      _callFunction(_createExpense(model, file));

  Future<dynamic> updateExpense(
          String? objectId, MyExpenseModel model, File? file) =>
      _callFunction(_updateExpense(objectId!, model, file));

  Future<dynamic> deleteExpense(String? objectId) =>
      _callFunction(_deleteExpense(objectId!));

  Future<dynamic> _callFunction(Future<dynamic> function) async {
    try {
      return await function;
    } catch (error) {
      return ParseError(code: 125, message: error.toString());
    }
  }
}
