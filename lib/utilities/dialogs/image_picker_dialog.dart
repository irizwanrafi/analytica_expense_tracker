import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../buttons/my_simple_button.dart';
import '../decorators.dart';
import '../rizfi_bars/rizfi_scrollbars.dart';
import '../rizfi_bars/rizfi_tab_bar.dart';
import '../snackbars/error_snackbar.dart';
import '../snackbars/message_snackbar.dart';

void showMyImagePickerDialog({
  required BuildContext context,
  required Function onSelect,
  bool circular = false,
}) {
  showDialog(
    context: context,
    builder: (bContext) =>
        _MyImagePickerDialog(onSelect: onSelect, circular: circular),
  );
}

class _MyImagePickerDialog extends StatelessWidget {
  const _MyImagePickerDialog({required this.onSelect, required this.circular});
  final Function onSelect;
  final bool circular;

  @override
  Widget build(BuildContext context) {
    Rx<XFile?> pickedImage = Rx<XFile?>(null);
    return Dialog(
      child: Container(
        width: 400,
        height: 450,
        padding: const EdgeInsets.only(left: 8.0, top: 16.0, right: 8.0),
        child: RizfiScrollBars(
          child: RizfiTabBar(
            iconsSize: 28,
            titlesFontSize: 14,
            expandedTabs: true,
            showDivider: false,
            showTabBoarder: true,
            tabsBorderColor: MyColors.c6.withOpacity(0.2),
            iconsColor: MyColors.c6.withOpacity(0.75),
            tabsColor: MyColors.c6.withOpacity(0.1),
            rizfiTabList: [
              RizfiTab(
                icon: Icons.image_rounded,
                title: 'Gallery',
                onTap: () async =>
                    pickedImage.value = await _pickImage(ImageSource.gallery),
              ),
              RizfiTab(
                icon: Icons.camera_alt_rounded,
                title: 'Camera',
                onTap: () async =>
                    pickedImage.value = await _pickImage(ImageSource.camera),
              ),
            ],
            bodyWidget: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Obx(() => Expanded(
                        child: circular
                            ? CircleAvatar(
                                radius: 150,
                                backgroundColor: MyColors.c3,
                                backgroundImage: pickedImage.value != null
                                    ? FileImage(File(pickedImage.value!.path))
                                    : null,
                                child: pickedImage.value == null
                                    ? const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.photo_outlined,
                                            size: 125,
                                            color: MyColors.c2,
                                          ),
                                          Text(
                                            'Pick/Capture an image',
                                            style: TextStyle(
                                              color: MyColors.c2,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      )
                                    : null,
                              )
                            : pickedImage.value == null
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                          size: 200,
                                          Icons.image_rounded,
                                          color: MyColors.c2.withOpacity(0.5)),
                                      Text(
                                        'Pick/Capture an image',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: MyColors.c2.withOpacity(0.75),
                                        ),
                                      )
                                    ],
                                  )
                                : Image(
                                    image: FileImage(
                                    File(pickedImage.value!.path),
                                  )),
                      )),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Expanded(
                        child: MySimpleButton(
                          title: 'Cancel',
                          buttonColor: Colors.red,
                          onTap: () => Navigator.pop(context),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: MySimpleButton(
                          title: 'Select',
                          buttonColor: Colors.green,
                          onTap: () {
                            if (pickedImage.value == null) {
                              showMyMessageSnackbar(
                                  'Alert 125', 'Please Pick/Capture Image');
                            } else {
                              Navigator.pop(context);
                              onSelect(pickedImage.value);
                            }
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<XFile?> _pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      return await picker.pickImage(source: source);
    } catch (e) {
      showMyErrorSnackbar(e.toString());
    }
    return null;
  }
}
