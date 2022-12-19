import 'package:flutter/material.dart';
import 'package:ligretto_counter/constants.dart';

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
  Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  Color buttonBackgroundColor = Colors.white;

  @override
  void initState() {
    buttonBackgroundColor = widget.backgroundColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) {
        setState(() {
          buttonBackgroundColor = darken(buttonBackgroundColor, 0.2);
        });
      },
      onTapUp: (_) {
        setState(() {
          buttonBackgroundColor = widget.backgroundColor;
        });
      },
      child: Container(
        height: widget.size,
        width: widget.size,
        decoration: BoxDecoration(
          color: buttonBackgroundColor,
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
