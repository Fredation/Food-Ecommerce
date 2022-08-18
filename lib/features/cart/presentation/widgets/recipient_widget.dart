import 'package:flutter/material.dart';
import 'package:food_ecommerce/features/cart/domain/entities/recipient.dart';
import 'package:food_ecommerce/features/cart/presentation/widgets/add_recipient.dart';

class RecipientWidget extends StatelessWidget {
  final Recipient recipient;
  const RecipientWidget({Key? key, required this.recipient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // margin: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, AddRecipient.routeName),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Update Recipient",
                        style: TextStyle(
                          color: Colors.brown[300],
                          fontSize: 12,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        recipient.name,
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
                  recipient.phone,
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
    );
  }
}
