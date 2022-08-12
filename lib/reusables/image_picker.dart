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
        ? await _picker.pickImage(
            source: ImageSource.gallery,
            imageQuality: 70,
            maxHeight: 200,
            maxWidth: 200,
          )
        : await _picker.pickImage(
            source: ImageSource.camera,
            imageQuality: 70,
            maxHeight: 200,
            maxWidth: 200,
          );

    setState(() {
      _pickedImage = _image;
    });
    if (_pickedImage != null) {
      await context
          .read<AuthCubit>()
          .saveUserImageToStorage(imageFile: File(_pickedImage!.path));
      await context.read<AuthCubit>().getUserData();
    }
  }

  @override
  void initState() {
    context.read<AuthCubit>().getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _userImage = context.read<AuthCubit>().userData?.imageUrl;
    return Column(
      children: [
        _userImage != null
            ? CircleAvatar(
                backgroundImage: NetworkImage(
                  _userImage,
                ),
                backgroundColor: Colors.transparent,
                radius: 45,
              )
            : _pickedImage == null
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
            _userImage == null ? 'Upload Photo' : 'Update Photo',
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
