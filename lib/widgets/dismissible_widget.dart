import 'package:flutter/material.dart';

class DismissibleWidget<T> extends StatelessWidget {
  final T item;
  final Widget child;
  final DismissDirectionCallback onDismissed;
 // final Function ondismiss;

  DismissibleWidget({
    required this.item,
    required this.child,
   required this.onDismissed,

  }) ;

  @override
  Widget build(BuildContext context) => Dismissible(
    direction: DismissDirection.endToStart,
    key: ObjectKey(item),
    background: buildSwipeActionRight(),
    child: child,
   onDismissed: onDismissed,
  );

  // Widget buildSwipeActionLeft() => Container(
  //   alignment: Alignment.centerLeft,
  //   padding: EdgeInsets.symmetric(horizontal: 20),
  //   color: Colors.green,
  //   child: Icon(Icons.archive_sharp, color: Colors.white, size: 32),
  // );

  Widget buildSwipeActionRight() => Container(
    alignment: Alignment.centerRight,
    padding: EdgeInsets.symmetric(horizontal: 20),
    color: Colors.red,
    child: Icon(Icons.delete_forever, color: Colors.white, size: 32),
  );
}