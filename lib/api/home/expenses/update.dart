part of dashboard_apis;

Future<dynamic> _updateExpense(
    String objectId, MyExpenseModel model, File? file) async {
  QueryBuilder<ParseObject> query = QueryBuilder(ParseObject('Expenses'))
    ..whereEqualTo('objectId', objectId);
  ParseObject? object = await query.first();
  if (object != null) {
    ParseFile? parseFile;
    if (file != null) {
      parseFile = ParseFile(file);
      ParseResponse fileResponse = await parseFile.save();
      if (fileResponse.error != null) return fileResponse.error;
    }
    object
      ..set('date', model.date)
      ..set('category', model.category)
      ..set('amount', model.amount)
      ..set('description', model.description)
      ..set('attachment', parseFile);
    ParseResponse response = await object.save();
    if (response.error != null) return response.error;
    return parseObjectToExpenseModel(object);
  } else {
    return ParseError(code: 125, message: 'No object found!');
  }
}
