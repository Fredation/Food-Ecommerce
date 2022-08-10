import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  String title;
  final Widget? bottom;
  final double bottomHeight;
  MyAppBar(
      {Key? key, required this.title, this.bottom, this.bottomHeight = 100})
      : super(key: key);

  @override
  Size get preferredSize =>
      Size.fromHeight(bottom == null ? kToolbarHeight : bottomHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      titleSpacing: 70,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w600,
        ),
      ),
      leading: GestureDetector(
        onTap: () {
          Navigator.maybePop(context);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 30),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(201, 201, 201, 0.1),
                  borderRadius: BorderRadius.circular(8)),
              alignment: Alignment.center,
              child: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
