part of dashboard_view;

void _addExpense(BuildContext context) async {
  showDialog(
    context: context,
    builder: (bContext) => const _MyExpenseDialog(null),
  );
}

void _modifyExpense(BuildContext context, int index) async {
  showDialog(
      context: context,
      builder: (dContext) => MyMessageDialog(
            title: 'Modification',
            message: 'Please select Edit/Delete expense.',
            redText: 'Delete',
            onRedTap: () {
              showDialog(
                  context: context,
                  builder: (bContext) => MyMessageDialog(
                        title: 'Confirmation',
                        message: 'Are you sure to delete this expense?',
                        onRedTap: () {},
                        greenText: 'Confirm',
                        onGreenTap: () async {
                          ParseError? response =
                              await _controller.deleteExpense(index);
                          if (context.mounted && response != null) {
                            showMyParseErrorDialog(context, response);
                          }
                        },
                      ));
            },
            greenText: 'Edit',
            onGreenTap: () {
              showDialog(
                  context: context,
                  builder: (bContext) => _MyExpenseDialog(index));
            },
            blueText: 'Cancel',
            onBlueTap: () {},
          ));
}

class _MyExpenseDialog extends StatefulWidget {
  const _MyExpenseDialog(this.index);
  final int? index; // null for add, value for update

  @override
  State<_MyExpenseDialog> createState() => _MyExpenseDialogState();
}

class _MyExpenseDialogState extends State<_MyExpenseDialog> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _date, _category, _amount, _description;
  late DateTime _dateTime;
  late File? _mySelectedFile;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _date = TextEditingController();
    _category = TextEditingController();
    _amount = TextEditingController();
    _description = TextEditingController();
    if (widget.index != null) {
      MyExpenseModel model = _controller.expenses[widget.index!];
      _dateTime = model.date;
      _date.text = DateFormat('dd-MM-yyyy').format(_dateTime);
      _category.text = model.category;
      _amount.text = model.amount.toString();
      _description.text = model.description;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyGeneralDialog(
      width: 300,
      title: widget.index == null ? 'New Expense' : 'Update Expense',
      bodyWidget: Form(
        key: _formKey,
        child: Column(
          children: [
            MyButtonTFF(
              label: 'Date',
              controller: _date,
              onTap: () => showMyDatePickerDialog(
                context: context,
                multiple: false,
                range: false,
                multiRange: false,
                time: false,
                onSelect: (selectionModeIndex, args) {
                  _dateTime = args.value;
                  _date.text = DateFormat('dd-MM-yyyy').format(args.value);
                },
              ),
            ),
            MyDropdownTFF(
              search: false,
              label: 'Category',
              items: _controller.categories,
              selectedString: widget.index == null ? null : _category.text,
              onChanged: (String value) => _category.text = value,
            ),
            MyGeneralTFF(
              label: 'Amount',
              regularExpression: numberRegex,
              controller: _amount,
            ),
            MyGeneralTFF(
              label: 'Description',
              controller: _description,
            ),
            _fileWidget(50, null),
          ],
        ),
      ),
      onRedTap: () => Navigator.pop(context),
      greenText: widget.index == null ? 'Add' : 'Update',
      onGreenTap: () async {
        if (_formKey.currentState!.validate()) {
          Navigator.pop(context);
          MyExpenseModel model = MyExpenseModel(
              category: _category.text.trim(),
              description: _description.text.trim(),
              amount: double.parse(_amount.text.trim()),
              date: _dateTime);
          ParseError? response = widget.index == null
              ? await _controller.addNewExpense(model, _mySelectedFile)
              : await _controller.updateExpense(
                  widget.index!, model, _mySelectedFile);
          if (context.mounted && response != null) {
            showMyParseErrorDialog(context, response);
          }
        }
      },
    );
  }

  Widget _fileWidget(double size, String? url) {
    _mySelectedFile = null;
    return MyAttachment(
      radius: size,
      editable: true,
      onSelect: (File? value) => _mySelectedFile = value,
      displayPictureUrl: widget.index == null
          ? null
          : _controller.expenses[widget.index!].attachmentUrl,
    );
  }
}
