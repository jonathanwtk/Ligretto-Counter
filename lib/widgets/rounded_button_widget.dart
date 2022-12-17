import 'package:flutter/material.dart';
import 'package:ligretto_counter/constants.dart';
import 'package:ligretto_counter/widgets/content_box_widget.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function onTap;
  final Color? color;
  final Color? textColor;

  const RoundedButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.color,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: ContentBox(
        color: color,
        height: 65,
        child: Center(
          child: Text(
            text,
            style: kPointsTextStyle.copyWith(color: textColor),
          ),
        ),
      ),
    );
  }
}
