import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ecommerce/core/data_utils/validators.dart';
import 'package:food_ecommerce/features/address/domain/entities/address.dart';
import 'package:food_ecommerce/features/address/presentation/state/address_cubit.dart';
import 'package:food_ecommerce/features/cart/presentation/state/cart_cubit.dart';
import 'package:food_ecommerce/reusables/input_field.dart';
import 'package:food_ecommerce/reusables/loader_view.dart';
import 'package:food_ecommerce/reusables/my_appbar.dart';

class AddAddress extends StatefulWidget {
  static const routeName = "/add-address";
  const AddAddress({Key? key}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  Address? add;
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  bool _isEnabled = true;

  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MyFormValidator.contentErr = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final addressCubit = context.read<AddressCubit>();
    final cartCubit = context.read<CartCubit>();
    //final addressCubit1 = context.read<AddressCubit>();
    // final addresses = ['Add New Address'];
    // addresses.addAll(addressCubit.addresses);
    return LoaderLayout(
      loading: addressCubit.state.isLoading,
      overlay: true,
      child: Scaffold(
        appBar: MyAppBar(
          title: 'Add Address',
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () async {
            if (add == null) {
              if (_formKey.currentState!.validate()) {
                await addressCubit.createAddress(
                  houseNumber: _numberController.text,
                  street: _streetController.text,
                  city: _cityController.text,
                  states: _stateController.text,
                  country: _countryController.text,
                );

                await cartCubit.addCartAddress(
                  houseNumber: _numberController.text,
                  street: _streetController.text,
                  city: _cityController.text,
                  states: _stateController.text,
                  country: _countryController.text,
                );
                Navigator.pop(context);
              }
            } else {
              await cartCubit.addCartAddress(
                houseNumber: add!.houseNumber,
                street: add!.street,
                city: add!.city,
                states: add!.state,
                country: add!.country,
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
                'Use this Address',
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
                  'Change location where\norder is  delivered!',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 20,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 40),
                PopupMenuButton(
                  position: PopupMenuPosition.under,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  offset: const Offset(0, 12),
                  constraints: const BoxConstraints(minWidth: 0),
                  onSelected: (c) {
                    // log(c.toString());
                    if (c is Address) {
                      add = c;
                      _numberController.text = c.houseNumber.toString().trim();
                      _streetController.text = c.street.toString().trim();
                      _cityController.text = c.city.toString().trim();
                      _stateController.text = c.state.toString().trim();
                      _countryController.text = c.country.toString().trim();
                      _isEnabled = false;
                    } else {
                      add = null;
                      _numberController.clear();
                      _streetController.clear();
                      _cityController.clear();
                      _stateController.clear();
                      _countryController.clear();
                      _isEnabled = true;
                    }
                    setState(() {});
                  },
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        value: '',
                        child: Text(
                          'Add New Address',
                          style:
                              Theme.of(context).textTheme.caption!.copyWith(),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      ...addressCubit.addresses
                          .map<PopupMenuItem<Address?>>(
                            (address) => PopupMenuItem(
                              value: address,
                              child: Text(
                                '${address.houseNumber} ${address.street} ${address.city} ${address.state} ${address.country}',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                          .toList()
                    ];
                  },
                  child: AbsorbPointer(
                    absorbing: true,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(8)),
                      child: DropdownButtonFormField<Address>(
                          decoration: InputDecoration(
                              // suffix: const Icon(Icons.keyboard_arrow_down_rounded),
                              // : ,
                              fillColor: Colors.grey[100],
                              filled: true,
                              labelText: 'Select Address',
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(fontSize: 12, color: Colors.black),
                              border: InputBorder.none),
                          borderRadius: BorderRadius.circular(8),
                          icon: const Icon(Icons.keyboard_arrow_down_rounded),
                          items: [
                            const DropdownMenuItem(
                              // value: e,
                              child: FittedBox(
                                  //width: 240,
                                  child: Text(
                                'Add New Address',
                                overflow: TextOverflow.ellipsis,
                              )),
                            ),
                            ...addressCubit.addresses
                                .map<DropdownMenuItem<Address>>(
                                  (address) => DropdownMenuItem(
                                    value: address,
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.67,
                                      child: Text(
                                        '${address.houseNumber} ${address.street} ${address.city} ${address.state} ${address.country}',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                )
                                .toList()
                          ],
                          style:
                              Theme.of(context).textTheme.caption!.copyWith(),
                          value: add,
                          onChanged: (c) {
                            // log(c.toString());
                            // if (c == null) {
                            //   add = c;
                            // }
                            setState(() {});
                          }),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                InputField(
                  hintText: 'House Number',
                  controller: _numberController,
                  isEnabled: _isEnabled,
                  validator: MyFormValidator.validateContent,
                  errorText: MyFormValidator.contentErr,
                ),
                const SizedBox(height: 20),
                InputField(
                  hintText: 'Street',
                  controller: _streetController,
                  isEnabled: _isEnabled,
                  validator: MyFormValidator.validateContent,
                  errorText: MyFormValidator.contentErr,
                ),
                const SizedBox(height: 20),
                InputField(
                  hintText: 'Area',
                  controller: _cityController,
                  isEnabled: _isEnabled,
                  validator: MyFormValidator.validateContent,
                  errorText: MyFormValidator.contentErr,
                ),
                const SizedBox(height: 20),
                InputField(
                  hintText: 'State',
                  controller: _stateController,
                  isEnabled: _isEnabled,
                  validator: MyFormValidator.validateContent,
                  errorText: MyFormValidator.contentErr,
                ),
                const SizedBox(height: 20),
                InputField(
                  hintText: 'Country',
                  controller: _countryController,
                  isEnabled: _isEnabled,
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
