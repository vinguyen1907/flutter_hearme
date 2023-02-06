import 'package:flutter/material.dart';
import 'package:hear_me/constants/app_styles.dart';

class ColorButton extends StatelessWidget {
  const ColorButton({
    Key? key,
    required this.size,
    required this.backgroundColor,
    required this.textColor,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  final Size size;
  final Color backgroundColor;
  final Color textColor;
  final String label;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(size.width * 0.9, size.height * 0.06),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        primary: backgroundColor,
        onPrimary: textColor,
      ),
      child: label == ""
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ),
            )
          : Text(label, style: AppStyles.buttonText.copyWith(color: textColor)),
    );
  }
}
