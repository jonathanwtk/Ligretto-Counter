import 'package:flutter/material.dart';
import 'package:ligretto_counter/constants.dart';

class CharacterSelectionCard extends StatelessWidget {
  final int index;
  final bool isSelected;
  final Function() onTap;

  const CharacterSelectionCard({
    Key? key,
    required this.index,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F3F3),
          borderRadius: BorderRadius.circular(10),
          border: isSelected ? Border.all(color: kRedColor, width: 2) : null,
        ),
        child: Image.asset(
          'assets/character/character$index.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
