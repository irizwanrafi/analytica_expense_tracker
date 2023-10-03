import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../decorators.dart';
import '../dialogs/image_picker_dialog.dart';

class MyAttachment extends StatelessWidget {
  const MyAttachment({
    super.key,
    required this.radius,
    required this.editable,
    required this.onSelect,
    required this.displayPictureUrl,
    this.displayIcon,
  });
  final double radius;
  final bool editable;
  final Function onSelect;
  final String? displayPictureUrl;
  final IconData? displayIcon;

  @override
  Widget build(BuildContext context) {
    Rx<File?> mySelectedFile = Rx<File?>(null);
    return InkWell(
      hoverColor: Colors.transparent,
      onTap: editable
          ? () => showMyImagePickerDialog(
                context: context,
                onSelect: (XFile imageXFile) {
                  mySelectedFile.value = File(imageXFile.path);
                  onSelect(mySelectedFile.value);
                },
                circular: radius > 0,
              )
          : null,
      child:
          Obx(() => (displayPictureUrl != null && mySelectedFile.value == null)
              ? Image(image: NetworkImage(displayPictureUrl!))
              : mySelectedFile.value == null
                  ? AspectRatio(
                      aspectRatio: 21 / 9,
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Icon(Icons.image_rounded,
                            color: MyColors.c2.withOpacity(0.2)),
                      ),
                    )
                  : Image(image: FileImage(mySelectedFile.value!))),
    );
  }
}
