import 'package:flutter/material.dart';

const double kBorderRadius = 40;

const Color kRedColor = Color(0xFF941912);

const TextStyle gameInformationTextStyle = TextStyle(
  fontSize: 20,
  fontFamily: 'Bubblegum',
);

const TextStyle gameInformationHeadlineTextStyle = TextStyle(
  fontSize: 24,
  fontFamily: 'Bubblegum',
);

const TextStyle kPlayerNameTextStyle = TextStyle(
  fontSize: 36,
  fontFamily: 'Bubblegum',
);

const TextStyle kPointsTextStyle = TextStyle(
  fontSize: 30,
  fontFamily: 'Bubblegum',
);

const TextStyle kTextFieldTextStyle = TextStyle(
  fontSize: 20,
  fontFamily: 'Bubblegum',
);

final InputBorder kInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(15.0),
  gapPadding: 0,
  borderSide: const BorderSide(
    width: 2,
    style: BorderStyle.solid,
  ),
);

InputDecoration kNameInputdecoration(String hintText) => InputDecoration(
      contentPadding: const EdgeInsets.all(15),
      border: kInputBorder,
      focusedBorder: kInputBorder,
      hintText: hintText,
    );

const InputDecoration kPointsInputdecoration = InputDecoration(
  counterText: '',
  isCollapsed: true,
  contentPadding: EdgeInsets.zero,
  border: InputBorder.none,
  focusedBorder: InputBorder.none,
);

final List<BoxShadow> kShadow = [
  BoxShadow(
    color: Colors.black.withAlpha(128),
    offset: const Offset(3, 3),
    blurRadius: 6,
  ),
];
