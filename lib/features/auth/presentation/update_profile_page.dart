import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ecommerce/core/data_utils/validators.dart';
import 'package:food_ecommerce/features/auth/presentation/state/auth_cubit.dart';
import 'package:food_ecommerce/reusables/image_picker.dart';
import 'package:food_ecommerce/reusables/input_field.dart';
import 'package:food_ecommerce/reusables/loader_view.dart';
import 'package:food_ecommerce/reusables/my_appbar.dart';

class UpdateProfilePage extends StatefulWidget {
  static const routeName = '/update_profile';
  const UpdateProfilePage({Key? key}) : super(key: key);

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>();
    final userData = authState.userData;

    final TextEditingController _usernameController =
        TextEditingController(text: userData?.userName ?? "username");
    final TextEditingController _emailController =
        TextEditingController(text: userData?.email ?? "email address");

    final TextEditingController _phoneController =
        TextEditingController(text: userData?.phoneNumber ?? "phone number");

    return LoaderLayout(
      loading: authState.state.isLoading,
      overlay: true,
      child: Scaffold(
        appBar: MyAppBar(
          title: 'Update Profile',
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.only(bottom: 30, right: 30, left: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    await authState.saveUserToDB(
                      email: _emailController.text,
                      phoneNumber: _phoneController.text,
                      userName: _usernameController.text,
                    );
                    Navigator.of(context).pop();
                  }
                },
                child: Container(
                  height: 50,
                  width: 211,
                  decoration: BoxDecoration(
                    color: Colors.brown[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'Update Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const ImagePickerWidget(),
                const SizedBox(height: 40),
                InputField(
                  hintText: 'Username',
                  controller: _usernameController,
                  validator: MyFormValidator.validateContent,
                  errorText: MyFormValidator.contentErr,
                ),
                const SizedBox(height: 20),
                InputField(
                  hintText: 'Phone',
                  controller: _phoneController,
                  validator: MyFormValidator.validatePhonenumber,
                  errorText: MyFormValidator.phoneErr,
                ),
                const SizedBox(height: 20),
                InputField(
                  hintText: 'Email',
                  controller: _emailController,
                  validator: MyFormValidator.validateEmail,
                  errorText: MyFormValidator.emailErr,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
