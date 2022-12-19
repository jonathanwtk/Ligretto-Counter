import 'package:flutter/material.dart';
import 'package:ligretto_counter/constants.dart';
import 'package:ligretto_counter/functions/darken_color_extension.dart';

class CircularButton extends StatefulWidget {
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
  State<CircularButton> createState() => _CircularButtonState();
}

class _CircularButtonState extends State<CircularButton> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) {
        setState(() {
          isTapped = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          isTapped = false;
        });
      },
      onTapCancel: () {
        setState(() {
          isTapped = false;
        });
      },
      child: Container(
        height: widget.size,
        width: widget.size,
        decoration: BoxDecoration(
          color: isTapped
              ? widget.backgroundColor.darken(0.2)
              : widget.backgroundColor,
          shape: BoxShape.circle,
          boxShadow: widget.hasShadow ? kShadow : [],
        ),
        child: Icon(
          widget.icon,
          size: widget.iconSize,
        ),
      ),
    );
  }
}
