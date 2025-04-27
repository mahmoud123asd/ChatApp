import 'package:flutter/material.dart';

class CustomeButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final VoidCallback onTap;
  const CustomeButton({
    super.key,
    required this.text,
    required this.color,
    required this.textColor, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      minWidth: 200,
      height: 50,
      color: color,
      textColor: textColor,
      child: Text(text),
    );
  }
}
