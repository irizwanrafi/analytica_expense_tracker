part of dashboard_apis;

Future<ParseError?> _deleteExpense(String objectId) async {
  QueryBuilder<ParseObject> query = QueryBuilder(ParseObject('Expenses'))
    ..whereEqualTo('objectId', objectId);
  ParseObject? object = await query.first();
  if (object != null) {
    ParseResponse response = await object.delete();
    return response.error;
  } else {
    return ParseError(code: 125, message: 'No object found!');
  }
}
