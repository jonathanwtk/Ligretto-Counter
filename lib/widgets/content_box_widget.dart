import 'package:flutter/material.dart';
import 'package:ligretto_counter/constants.dart';

class ContentBox extends StatelessWidget {
  final Widget child;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final bool hasShadow;
  final double width;
  final double? height;
  final Color? color;

  const ContentBox({
    Key? key,
    required this.child,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.hasShadow = true,
    this.width = double.infinity,
    this.height,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(kBorderRadius),
      child: Container(
        margin: margin,
        padding: padding,
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          boxShadow: hasShadow ? kShadow : [],
        ),
        child: child,
      ),
    );
  }
}
