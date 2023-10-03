import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../decorators.dart';
import 'tff_decoration.dart';

class MyGeneralTFF extends StatelessWidget {
  const MyGeneralTFF(
      {Key? key,
      required this.label,
      this.controller,
      this.prefixIcon,
      this.suffixIcon,
      this.hints,
      this.isObscure = false,
      this.enabled = true,
      this.enableBehaviour = false,
      this.labelColor = MyColors.c2,
      this.boarderColor = MyColors.c2,
      this.regularExpression,
      this.textInputAction = TextInputAction.next,
      this.onChanged,
      this.onSubmitted,
      this.validate = true,
      this.validateItemExistence = const [],
      this.suffixClicked})
      : super(key: key);

  final String label;
  final TextEditingController? controller;
  final IconData? prefixIcon, suffixIcon;
  final String? hints;
  final bool isObscure, enabled, enableBehaviour, validate;
  final Color? labelColor, boarderColor;
  final String? regularExpression;
  final TextInputAction? textInputAction;
  final Function? onChanged, onSubmitted;
  final List<String> validateItemExistence;
  final VoidCallback? suffixClicked;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        obscureText: isObscure,
        style:
            TextStyle(color: enableBehaviour ? Colors.black54 : Colors.black87),
        inputFormatters: regularExpression != null
            ? [FilteringTextInputFormatter.allow(RegExp(regularExpression!))]
            : null,
        decoration: myTFFDecoration(
            label: label,
            labelColor: enableBehaviour ? Colors.black45 : labelColor,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            hints: hints,
            boarderColor: enableBehaviour ? Colors.black45 : boarderColor,
            suffixClicked: suffixClicked),
        textInputAction: textInputAction,
        onFieldSubmitted: (v) => onSubmitted != null ? onSubmitted!(v) : null,
        onChanged: (v) => onChanged != null ? onChanged!(v) : null,
        validator: (value) {
          if (value != null && validate) {
            if (value.trim().isEmpty) {
              return 'Required!';
            } else if (validateItemExistence.contains(value)) {
              return 'Already existed!';
            }
          }
          return null;
        },
      ),
    );
  }
}
