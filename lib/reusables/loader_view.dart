import 'package:flutter/material.dart';

class LoaderLayout extends StatelessWidget {
  final bool loading;
  final Widget child;
  final bool overlay;
  final Color? backgroundColor;
  const LoaderLayout(
      {Key? key,
      required this.loading,
      required this.child,
      this.overlay = false,
      this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      // backgroundColor: Colors.transparent,
      // color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      color: Colors.brown[300],
      child: AbsorbPointer(absorbing: loading, child: getView()),
    );
  }

  Widget getView() {
    if (overlay) {
      return Stack(
        children: [
          child,
          if (loading)
            Stack(
              children: [
                Container(
                  color: Colors.black.withOpacity(0.75),
                ),
                Center(
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.brown[300] ??
                          const Color.fromARGB(255, 108, 97, 93),
                    ),
                  ),
                ),
              ],
            ),
        ],
      );
    } else {
      return loading
          ? Center(
              child: CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.brown[300] ?? const Color.fromARGB(255, 108, 97, 93),
              ),
            ))
          : child;
    }
  }
}
