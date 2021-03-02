import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard(
      {@required this.color, this.child, this.onPressed, this.flex = 1});

  final Widget child;
  final Color color;
  final Function onPressed;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          child: child,
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
