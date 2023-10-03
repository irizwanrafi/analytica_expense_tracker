part of dashboard_apis;

Future<List<MyExpenseModel>> _loadExpenses() async {
  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject('Expenses'))
        ..orderByDescending('createdAt');
  ParseResponse response = await query.query();
  List<MyExpenseModel> list = [];
  if (response.results != null && response.results!.isNotEmpty) {
    for (ParseObject object in response.results as List<ParseObject>) {
      list.add(parseObjectToExpenseModel(object));
    }
  }
  return list;
}
