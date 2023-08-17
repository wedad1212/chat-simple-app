import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../themes.dart';

class ImagePickerUser extends StatefulWidget {
  final void Function(File pickedImage) pickFun;

  const ImagePickerUser(this.pickFun);

  @override
  State<ImagePickerUser> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePickerUser> {
  final ImagePicker _picker = ImagePicker();
  File? _pickedImage;

  void _pickImage(ImageSource source) async {
    final pickedImageFile = await _picker.pickImage(
        source: source, imageQuality: 50, maxWidth: 150);
    if (pickedImageFile != null) {
      setState(() {
        _pickedImage = File(pickedImageFile.path);
      });
      widget.pickFun(_pickedImage!);
    } else {
      print('no selected image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage!) : null,
          radius: 60,
        ),
        Positioned(
          bottom: 5,
          right: 0,
          child: GestureDetector(
            onTap: () => _buildBottomSheet(context),
            child: const CircleAvatar(
              backgroundColor: blueBlackColor,
              radius: 20,
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }

  void _buildBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        width: double.infinity,
        height: 200,
        color: Colors.white,
        child: Column(
          children: [
            _buildContainerBottom(
                () => _pickImage(ImageSource.gallery),
                "Gallery",
                const Icon(
                  Icons.image_outlined,
                  size: 25,
                  color: Colors.white,
                )),
            _buildContainerBottom(
                () => _pickImage(ImageSource.camera),
                "Camera",
                const Icon(
                  Icons.camera_alt_outlined,
                  size: 25,
                  color: Colors.white,
                ))
          ],
        ),
      ),
    );
  }

  Container _buildContainerBottom(
      GestureTapCallback onTap, String text, Icon icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: const EdgeInsets.all(15),
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: bronColor),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
                child: Text(
              text,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            )),
            icon
          ],
        ),
      ),
    );
  }
}
