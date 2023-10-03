part of dashboard_apis;

Future<dynamic> _createExpense(MyExpenseModel model, File? file) async {
  ParseFile? parseFile;
  if (file != null) {
    parseFile = ParseFile(file);
    ParseResponse fileResponse = await parseFile.save();
    if (fileResponse.error != null) return fileResponse.error;
  }
  ParseObject object = ParseObject('Expenses')
    ..set('date', model.date)
    ..set('category', model.category)
    ..set('amount', model.amount)
    ..set('description', model.description)
    ..set('attachment', parseFile);
  ParseResponse response = await object.save();
  if (response.error != null) return response.error;
  return parseObjectToExpenseModel(object);
}
