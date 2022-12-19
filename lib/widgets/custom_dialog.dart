import 'package:flutter/material.dart';
import 'package:ligretto_counter/widgets/content_box_widget.dart';

class CustomDialog extends StatelessWidget {
  final Widget content;
  final Widget? action;

  const CustomDialog({
    Key? key,
    required this.content,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Material(
              color: Colors.transparent,
              child: Column(
                children: [
                  ContentBox(
                    child: content,
                    padding: const EdgeInsets.all(20),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: action ?? const SizedBox(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
