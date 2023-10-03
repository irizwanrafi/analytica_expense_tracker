import 'package:flutter/material.dart';

import '../decorators.dart';

void showMyLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (c) => const _MyLoadingDialog(),
  );
}

class _MyLoadingDialog extends StatelessWidget {
  const _MyLoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 16),
                child: const CircularProgressIndicator(color: MyColors.c6)),
            const SizedBox(height: 10),
            const Text(
              'Loading...',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
