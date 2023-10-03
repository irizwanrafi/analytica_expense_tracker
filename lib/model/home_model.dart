import 'package:flutter/cupertino.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class MyPageModel {
  MyPageModel({
    required this.title,
    required this.iconData,
  });
  final String title;
  final IconData iconData;
}

class MyExpenseModel {
  MyExpenseModel(
      {this.objectId,
      required this.category,
      required this.description,
      required this.amount,
      required this.date,
      this.attachmentUrl});
  final String? objectId;
  final String category, description;
  final double amount;
  final DateTime date;
  final String? attachmentUrl;
}

MyExpenseModel parseObjectToExpenseModel(ParseObject object) {
  return MyExpenseModel(
    objectId: object.objectId,
    category: object.get<String>('category')!,
    description: object.get<String>('description')!,
    amount: object.get<num>('amount')!.toDouble(),
    date: object.get<DateTime>('date')!,
    attachmentUrl: object.get<ParseFileBase>('attachment')?.url,
  );
}
