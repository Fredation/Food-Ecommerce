import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ecommerce/core/data_utils/validators.dart';
import 'package:food_ecommerce/features/cart/presentation/state/cart_cubit.dart';
import 'package:food_ecommerce/reusables/input_field.dart';
import 'package:food_ecommerce/reusables/loader_view.dart';
import 'package:food_ecommerce/reusables/my_appbar.dart';

class AddRecipient extends StatefulWidget {
  static const routeName = "/change-reci";

  const AddRecipient({Key? key}) : super(key: key);

  @override
  State<AddRecipient> createState() => _AddRecipientState();
}

class _AddRecipientState extends State<AddRecipient> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MyFormValidator.contentErr = null;
    MyFormValidator.phoneErr = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<CartCubit>();
    return LoaderLayout(
      loading: cartCubit.state.isLoading,
      overlay: true,
      child: Scaffold(
        appBar: MyAppBar(
          title: 'Add Recipient',
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () async {
            if (_formKey.currentState!.validate()) {
              await cartCubit.addRecipient(
                name: _nameController.text,
                phone: _phoneController.text,
              );
              Navigator.pop(context);
            }
          },
          child: Container(
            height: 50,
            margin: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
            decoration: BoxDecoration(
              color: Colors.brown[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                'Save Changes',
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
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Change who receives\nyour order',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 20,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 40),
                InputField(
                  hintText: 'Name',
                  controller: _nameController,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
