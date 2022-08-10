import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ecommerce/features/address/presentation/create_address.dart';
import 'package:food_ecommerce/features/address/presentation/state/address_cubit.dart';
import 'package:food_ecommerce/reusables/my_appbar.dart';

class AddressPage extends StatefulWidget {
  static const routeName = '/address-page';
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  @override
  Widget build(BuildContext context) {
    final addressCubit = context.watch<AddressCubit>();

    return Scaffold(
        appBar: MyAppBar(title: "Addresses"),
        floatingActionButton: GestureDetector(
          onTap: () {
            // HapticFeedback.lightImpact();
            Navigator.pushNamed(context, CreateAddress.routeName);
          },
          child: Container(
            height: 60,
            width: 60,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.brown[300]),
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Divider(
              thickness: 2,
            ),
            Expanded(
              child: ListView.builder(
                  itemBuilder: (ctx, index) {
                    final address = addressCubit.addresses[index];
                    return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        padding: const EdgeInsets.only(right: 30),
                        alignment: Alignment.centerRight,
                        decoration: BoxDecoration(
                          color: Colors.brown[300],
                        ),
                        child: const Text(
                          'Remove',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      onDismissed: (endToStart) async {
                        await addressCubit.deleteAddress(
                            aid: address.id.toString());
                        await addressCubit.getAddresses();
                      },
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.pushNamed(
                          //     context, AppRoutes.createAndUpdateAddresses,
                          //     arguments: true);
                        },
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "${address.houseNumber} ${address.street}",
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontFamily: 'Lato',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          '${address.city}, ${address.state} - ${address.country}',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'Lato',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              thickness: 2,
                              height: 0,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: addressCubit.addresses.length),
            )
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
  }
}
