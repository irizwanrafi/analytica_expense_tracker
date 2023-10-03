import 'package:flutter/material.dart';

import '../decorators.dart';
import 'tff_decoration.dart';

class MyButtonTFF extends StatelessWidget {
  const MyButtonTFF(
      {Key? key,
      required this.label,
      this.controller,
      this.prefixIcon,
      this.labelColor = MyColors.c2,
      this.boarderColor = MyColors.c2,
      this.onTap,
      this.validate = true,
      this.enableBehaviour = false,
      this.validateItemExistence})
      : super(key: key);

  final String label;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final bool? validate;
  final bool enableBehaviour;
  final Color? labelColor, boarderColor;
  final VoidCallback? onTap;
  final List<String>? validateItemExistence;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(8.0),
        mouseCursor: SystemMouseCursors.click,
        onTap: onTap,
        child: TextFormField(
          controller: controller,
          enabled: false,
          style: TextStyle(
              color: enableBehaviour ? Colors.black54 : Colors.black87),
          decoration: myTFFDecoration(
            label: label,
            labelColor: enableBehaviour ? Colors.black45 : labelColor,
            prefixIcon: prefixIcon,
            boarderColor: enableBehaviour ? Colors.black45 : boarderColor,
          ),
          validator: (value) {
            if (value != null && validate!) {
              if (value.isEmpty) {
                return 'Required!';
              } else if (validateItemExistence != null &&
                  validateItemExistence!.contains(value)) {
                return 'Already existed!';
              }
            }
            return null;
          },
        ),
      ),
    );
  }
}
