import 'package:get/get.dart';

import '../decorators.dart';

void showMyMessageSnackbar(String title, String message) {
  Get.snackbar(
    title,
    'Message: $message',
    backgroundColor: MyColors.c2.withOpacity(0.75),
  );
}
