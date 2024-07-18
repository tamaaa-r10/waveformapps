import 'package:flutter/material.dart';

class IconButtonBack extends StatelessWidget {
  final IconData icon;
  final double size;
  final double iconSize;
  final Color color;
  final VoidCallback onPressed;

  IconButtonBack({
    required this.icon,
    required this.size,
    required this.iconSize,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, blurRadius: 5.0, spreadRadius: 1.0)
            ]),
        child: Center(
          child: Icon(
            icon,
            size: iconSize,
            color: color,
          ),
        ),
      ),
    );
  }
}
