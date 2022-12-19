import 'package:flutter/material.dart';
import 'package:ligretto_counter/constants.dart';
import 'package:ligretto_counter/widgets/content_box_widget.dart';
import 'package:ligretto_counter/functions/darken_color_extension.dart';

class RoundedButton extends StatefulWidget {
  final String text;
  final Function onTap;
  final Color color;
  final Color? textColor;

  const RoundedButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.color = Colors.white,
    this.textColor,
  }) : super(key: key);

  @override
  State<RoundedButton> createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap(),
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
      child: ContentBox(
        color: isTapped ? widget.color.darken(0.2) : widget.color,
        height: 65,
        child: Center(
          child: Text(
            widget.text,
            style: kPointsTextStyle.copyWith(color: widget.textColor),
          ),
        ),
      ),
    );
  }
}
