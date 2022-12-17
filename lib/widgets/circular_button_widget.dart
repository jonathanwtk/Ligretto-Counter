import 'package:flutter/material.dart';
import 'package:ligretto_counter/constants.dart';

class CircularButton extends StatelessWidget {
  final IconData icon;
  final Function() onTap;
  final bool hasShadow;
  final double size;
  final double iconSize;
  final Color backgroundColor;

  const CircularButton({
    Key? key,
    required this.icon,
    required this.onTap,
    this.hasShadow = true,
    this.size = 57,
    this.iconSize = 35,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          boxShadow: hasShadow ? kShadow : [],
        ),
        child: Icon(
          icon,
          size: iconSize,
        ),
      ),
    );
  }
}
