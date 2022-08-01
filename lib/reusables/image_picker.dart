import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ecommerce/core/size_config/extensions.dart';
import 'package:food_ecommerce/features/auth/presentation/state/auth_cubit.dart';

import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({Key? key}) : super(key: key);

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  XFile? _pickedImage;
  bool isGallery = true;
  _uploadImage() async {
    final ImagePicker _picker = ImagePicker();

    final XFile? _image = isGallery
        ? await _picker.pickImage(source: ImageSource.gallery)
        : await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      _pickedImage = _image;
    });
    if (_pickedImage != null) {
      await context
          .read<AuthCubit>()
          .saveUserImageToStorage(imageFile: File(_pickedImage!.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    // bool? isGallery;
    return Column(
      children: [
        _pickedImage == null
            ? const CircleAvatar(
                backgroundImage: AssetImage(
                  'assets/images/cartoon_chef.png',
                ),
                backgroundColor: Colors.transparent,
                radius: 45,
              )
            : CircleAvatar(
                backgroundImage: FileImage(
                  File(_pickedImage!.path),
                ),
                backgroundColor: Colors.transparent,
                radius: 45,
              ),
        TextButton.icon(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent
                //const Color.fromARGB(255, 161, 136, 127),
                ),
          ),
          onPressed: _uploadImage,
          icon: Icon(
            Icons.image,
            color: Colors.brown[300],
          ),
          label: Text(
            'Upload Photo',
            style: TextStyle(
              fontFamily: 'Lato',
              fontSize: 18.width,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
