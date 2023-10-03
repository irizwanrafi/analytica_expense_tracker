import 'package:flutter/material.dart';

import '../decorators.dart';

InputDecoration myTFFDecoration({
  String? label,
  Color? labelColor = MyColors.c2,
  IconData? prefixIcon,
  IconData? suffixIcon,
  bool suffixLoading = false,
  String? hints,
  Color? boarderColor = MyColors.c2,
  VoidCallback? suffixClicked,
}) {
  return InputDecoration(
    isDense: true,
    prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
    suffixIcon: suffixIcon != null
        ? IconButton(
            hoverColor: Colors.transparent,
            icon: Icon(suffixIcon),
            onPressed: suffixClicked,
          )
        : suffixLoading
            ? Transform.scale(
                scale: 0.5,
                child: const CircularProgressIndicator(
                  color: MyColors.c6,
                ),
              )
            : null,
    contentPadding: const EdgeInsets.all(16),
    label: label != null
        ? Text(label,
            style: TextStyle(color: labelColor),
            overflow: TextOverflow.ellipsis)
        : null,
    hintText: hints,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: boarderColor!)),
    disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: boarderColor)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: boarderColor)),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: boarderColor)),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.red.shade700)),
  );
}
