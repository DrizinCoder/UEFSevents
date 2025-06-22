import 'package:flutter/material.dart';

/// Um seletor customizado com o design especificado no Figma.
class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        width: 84.08,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFF4A5F53),
          borderRadius: BorderRadius.circular(18),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 250),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          curve: Curves.easeInOut,
          child: Container(
            width: 43.09,
            height: 34,
            margin: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: const Color(0xFFF4B134),
              borderRadius: BorderRadius.circular(28),
            ),
          ),
        ),
      ),
    );
  }
} 