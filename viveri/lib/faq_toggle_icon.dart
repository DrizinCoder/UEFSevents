import 'package:flutter/material.dart';

class ToggleIcon extends StatefulWidget {
  final IconData outlinedIcon;
  final IconData filledIcon;
  final Color activeColor;
  final Color inactiveColor;
  final int initialCount;
  final void Function(bool)? onChanged;
  final bool initialState;

  const ToggleIcon({
    super.key,
    required this.outlinedIcon,
    required this.filledIcon,
    this.activeColor = Colors.green,
    this.inactiveColor = Colors.white,
    this.initialCount = 0,
    this.initialState = false,
    this.onChanged,
  });

  @override
  State<ToggleIcon> createState() => _ToggleIconState();
}

class _ToggleIconState extends State<ToggleIcon> {
  late bool isActive;
  late int count;

  @override
  void initState() {
    super.initState();
    isActive = widget.initialState;
    count = widget.initialCount;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            isActive ? widget.filledIcon : widget.outlinedIcon,
            color: isActive ? widget.activeColor : widget.inactiveColor,
          ),
          onPressed: () {
            setState(() {
              isActive = !isActive;
              count += isActive ? 1 : -1;
            });
            widget.onChanged?.call(isActive);
          },
        ),
        Text(
          '$count',
          style: TextStyle(
            color: isActive ? widget.activeColor : widget.inactiveColor,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
