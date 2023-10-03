import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../decorators.dart';

void showMyParseErrorSnackbar(ParseError error) {
  Get.snackbar(
    'Error code: ${error.code}',
    'Message: ${error.message}',
    backgroundColor: MyColors.c2.withOpacity(0.75),
  );
}

void showMyErrorSnackbar(String message) {
  Get.snackbar(
    'Error code: 125',
    'Message: $message',
    backgroundColor: MyColors.c2.withOpacity(0.75),
  );
}
