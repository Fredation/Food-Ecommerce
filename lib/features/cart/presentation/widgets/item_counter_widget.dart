import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ItemCounterWidget extends StatefulWidget {
  final Function(int count) onChanged;
  final int count;
  const ItemCounterWidget(
      {Key? key, required this.onChanged, required this.count})
      : super(key: key);

  @override
  State<ItemCounterWidget> createState() => _ItemCounterWidgetState();
}

class _ItemCounterWidgetState extends State<ItemCounterWidget> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.brown[300]!.withOpacity(.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              if (count > 1) {
                count--;
                widget.onChanged(count);
              } else {
                widget.onChanged(0);
              }
            },
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
              ),
              child: Icon(
                Icons.remove,
                size: 20,
                color: Colors.brown[300],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(widget.count.toString(),
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontSize: 16,
                    )),
          ),
          GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              count++;
              widget.onChanged(count);
            },
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
              ),
              child: Icon(
                Icons.add,
                size: 20,
                color: Colors.brown[300],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    count = widget.count;
    super.initState();
  }
}
