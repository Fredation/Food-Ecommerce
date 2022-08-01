import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class MyToast {
  static show(
      {required BuildContext context,
      required String text,
      bool isError = false}) {
    Future.delayed(const Duration(seconds: 3), () {
      ScaffoldMessenger.of(context).clearMaterialBanners();
    });
    showSimpleNotification(
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ]),
          child: Row(
            children: [
              Container(
                width: 5,
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.caption!.copyWith(
                      color: isError ? Theme.of(context).errorColor : null),
                ),
              )
            ],
          ),
        ),
        elevation: 0,
        slideDismissDirection: DismissDirection.up,
        background: Colors.transparent);
  }
}
