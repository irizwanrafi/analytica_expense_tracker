import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import 'message_dialog.dart';

void showMyParseErrorDialog(BuildContext context, ParseError error) {
  showDialog(
      context: context,
      builder: (dContext) => MyMessageDialog(
          title: 'Error code: ${error.code}',
          message: error.message,
          onGreenTap: () {}));
}
