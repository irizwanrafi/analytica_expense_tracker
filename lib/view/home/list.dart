part of dashboard_view;

class _Expenses extends StatelessWidget {
  const _Expenses({required this.expenses});
  final List<MyExpenseModel> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8.0),
      itemCount: expenses.length,
      itemBuilder: (BuildContext lContext, int index) => ListTile(
        dense: true,
        isThreeLine: true,
        onTap: () => _modifyExpense(context, index),
        title: Text(expenses[index].amount.toString(),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: MyColors.c2.withOpacity(0.9)),
            overflow: TextOverflow.ellipsis),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Category: ${expenses[index].category}',
                style: const TextStyle(color: Colors.black54),
                overflow: TextOverflow.ellipsis),
            Text('Description: ${expenses[index].description}',
                style: const TextStyle(color: Colors.black54),
                overflow: TextOverflow.ellipsis),
          ],
        ),
        trailing: Text(
          DateFormat('dd-MM-yyyy').format(expenses[index].date),
        ),
      ),
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
