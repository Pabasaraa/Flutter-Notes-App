import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;
  final double? size;
  final ShapeBorder? shape;

  const CustomButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.color,
    this.size,
    this.shape,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: color ?? Theme.of(context).primaryColor,
      shape: shape ?? const CircleBorder(),
      child: Icon(
        icon,
        size: size ?? 24.0,
      ),
    );
  }
}
