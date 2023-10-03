import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../decorators.dart';
import 'tff_decoration.dart';

class MyDropdownTFF extends StatefulWidget {
  const MyDropdownTFF(
      {Key? key,
      required this.label,
      required this.items,
      this.onChanged,
      this.prefixIcon,
      this.selectedString,
      this.labelColor = MyColors.c2,
      this.boarderColor = MyColors.c2,
      this.search = true,
      this.disableBehaviour = false,
      this.suffixLoading = false})
      : super(key: key);
  final String label;
  final List<String> items;
  final Function? onChanged;
  final IconData? prefixIcon;
  final String? selectedString;
  final Color? labelColor, boarderColor;
  final bool search, disableBehaviour, suffixLoading;

  @override
  State<MyDropdownTFF> createState() => _MyDropdownTFFState();
}

class _MyDropdownTFFState extends State<MyDropdownTFF> {
  late TextEditingController selectedItemController, textEditingController;
  bool isTFFEnable = false;

  @override
  void initState() {
    selectedItemController = TextEditingController();
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    selectedItemController.text = widget.selectedString ?? '--Select--';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          dropdownStyleData: const DropdownStyleData(
            elevation: 8,
            direction: DropdownDirection.left,
          ),
          buttonStyleData: ButtonStyleData(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
          ),
          customButton: MouseRegion(
            onHover: (value) {
              if (isTFFEnable) setState(() => isTFFEnable = false);
            },
            child: TextFormField(
              controller: selectedItemController,
              enabled: isTFFEnable,
              style: TextStyle(
                  color: widget.disableBehaviour
                      ? Colors.black54
                      : Colors.black87),
              decoration: myTFFDecoration(
                  label: widget.label,
                  prefixIcon: widget.prefixIcon,
                  labelColor: widget.disableBehaviour
                      ? Colors.black45
                      : widget.labelColor,
                  boarderColor: widget.disableBehaviour
                      ? Colors.black45
                      : widget.boarderColor,
                  suffixLoading: widget.suffixLoading),
              validator: (value) {
                if (value != null && value.toString() == '--Select--') {
                  setState(() => isTFFEnable = true);
                  return 'Required';
                }
                return null;
              },
            ),
          ),
          items: [
            const DropdownMenuItem(
                value: '--Select--',
                child: Text('--Select--', style: TextStyle(fontSize: 14))),
            ...widget.items
                .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(item, style: const TextStyle(fontSize: 14))))
                .toList()
          ],
          value: selectedItemController.text,
          onChanged: widget.onChanged != null
              ? (value) {
                  if (isTFFEnable) setState(() => isTFFEnable = false);
                  selectedItemController.text = value!;
                  widget.onChanged!(value);
                }
              : null,
          dropdownSearchData: widget.search
              ? DropdownSearchData(
                  searchController: textEditingController,
                  searchInnerWidgetHeight: 50,
                  searchInnerWidget: Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
                    child: TextFormField(
                      controller: textEditingController,
                      decoration: myTFFDecoration(
                        hints: 'Search ${widget.label}',
                        boarderColor: widget.boarderColor,
                      ),
                    ),
                  ),
                  searchMatchFn: (item, searchValue) {
                    return (item.value
                        .toString()
                        .toLowerCase()
                        .contains(searchValue.toLowerCase()));
                  },
                )
              : null,
          //This to clear the search value when you close the menu
          onMenuStateChange: (isOpen) {
            if (!isOpen && widget.search) textEditingController.clear();
            // FocusScope.of(context).requestFocus(FocusNode());
          },
        ),
      ),
    );
  }
}
