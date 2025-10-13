import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final bool isColor;

  const Button({
    super.key,
    required this.onPressed,
    required this.text,
    this.isColor = true,
    this.style,
  });

  final Function onPressed;
  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: BorderSide(color: Color(0xFF8875FF)),
        ),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        backgroundColor: isColor ? Color(0xFF8875FF) : Colors.transparent,
      ),
      child: Text(text, style: style),
    );
  }
}
