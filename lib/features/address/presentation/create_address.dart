import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ecommerce/core/data_utils/validators.dart';
import 'package:food_ecommerce/features/address/presentation/state/address_cubit.dart';
import 'package:food_ecommerce/reusables/input_field.dart';
import 'package:food_ecommerce/reusables/loader_view.dart';
import 'package:food_ecommerce/reusables/my_appbar.dart';

class CreateAddress extends StatefulWidget {
  static const routeName = '/create-address-page';
  const CreateAddress({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateAddress> createState() => _CreateAddressState();
}

class _CreateAddressState extends State<CreateAddress> {
  final _numberController = TextEditingController();

  final _streetController = TextEditingController();

  final _cityController = TextEditingController();

  final _stateController = TextEditingController();

  final _countryController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    MyFormValidator.contentErr = null;
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final addressCubit = context.read<AddressCubit>();
    return LoaderLayout(
      loading: addressCubit.state.isLoading,
      child: Scaffold(
        appBar: MyAppBar(
          title: 'Add Address',
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
                    await addressCubit.createAddress(
                        houseNumber: _numberController.text,
                        street: _streetController.text,
                        city: _cityController.text,
                        states: _stateController.text,
                        country: _countryController.text);
                    await addressCubit.getAddresses();
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
                      'Create Address',
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InputField(
                  hintText: 'House Number',
                  controller: _numberController,
                  validator: MyFormValidator.validateContent,
                  errorText: MyFormValidator.contentErr,
                ),
                const SizedBox(height: 20),
                InputField(
                  hintText: 'Street',
                  controller: _streetController,
                  validator: MyFormValidator.validateContent,
                  errorText: MyFormValidator.contentErr,
                ),
                const SizedBox(height: 20),
                InputField(
                  hintText: 'Area',
                  controller: _cityController,
                  validator: MyFormValidator.validateContent,
                  errorText: MyFormValidator.contentErr,
                ),
                const SizedBox(height: 20),
                InputField(
                  hintText: 'State',
                  controller: _stateController,
                  validator: MyFormValidator.validateContent,
                  errorText: MyFormValidator.contentErr,
                ),
                const SizedBox(height: 20),
                InputField(
                  hintText: 'Country',
                  controller: _countryController,
                  validator: MyFormValidator.validateContent,
                  errorText: MyFormValidator.contentErr,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
