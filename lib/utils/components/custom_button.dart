import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String btnName;
  final VoidCallback btnAction;
  final Color backgroundColor;
  final Color foregroundColor;
  Color borderColor;
  CustomButton({
    super.key,
    required this.btnName,
    required this.btnAction,
    required this.backgroundColor,
    required this.foregroundColor,
    this.borderColor = Colors.black
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: btnAction,
      child: Text(btnName),
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        side: BorderSide(color: borderColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(12.0)),
      ),
    );
  }
}
