import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RoundedIconButton extends StatelessWidget {
  final Function onPressed;
  final IconData iconData;

  const RoundedIconButton({
    @required this.onPressed,
    @required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 6.0,
      fillColor: Color(0xFF1C1F32),
      shape: CircleBorder(),
      constraints: BoxConstraints.tightFor(
        width: 56,
        height: 56,
      ),
      child: Icon(
        iconData,
        color: Colors.white,
      ),
    );
  }
}
