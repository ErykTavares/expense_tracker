import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor,
    this.bgColor,
  });

  final String text;
  final VoidCallback? onPressed;
  final Color? textColor;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    final bgColor = this.bgColor ?? Theme.of(context).colorScheme.surface;
    final textColor = this.textColor ?? Theme.of(context).colorScheme.primary;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.minPositive, 40),
        backgroundColor: bgColor,
        shadowColor: Colors.black.withValues(alpha: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onPressed,
      child: Text(text, style: TextStyle(color: textColor)),
    );
  }
}
