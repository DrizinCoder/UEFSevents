import 'package:flutter/material.dart';

class ToggleIcon extends StatelessWidget {
  final IconData outlinedIcon;
  final IconData filledIcon;
  final Color activeColor;
  final Color inactiveColor;
  final int count;
  final bool isActive;
  final VoidCallback onPressed;

  const ToggleIcon({
    super.key,
    required this.outlinedIcon,
    required this.filledIcon,
    required this.count,
    required this.isActive,
    required this.onPressed,
    this.activeColor = Colors.green,
    this.inactiveColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
          IconButton(
            icon: Icon(
              isActive ? filledIcon : outlinedIcon,
              color: isActive ? activeColor : inactiveColor,
              shadows: [
                Shadow(
                  color: Colors.black,
                  blurRadius: 2,
                ),
              ],
            ),
            onPressed: onPressed,
          ),
        Text(
          '$count',
          style: TextStyle(
            color: isActive ? activeColor : Colors.black,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

