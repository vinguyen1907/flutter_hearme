import 'package:flutter/material.dart';
import 'package:hear_me/constants/app_color.dart';
import 'package:hear_me/constants/app_styles.dart';

class MyOutlinedButton extends StatefulWidget {
  const MyOutlinedButton({
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
  State<MyOutlinedButton> createState() => _MyOutlinedButtonState();
}

class _MyOutlinedButtonState extends State<MyOutlinedButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => widget.onPressed(),
      style: ElevatedButton.styleFrom(
        // minimumSize: Size(size.width, size.height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        side: const BorderSide(
          color: AppColors.primaryColor,
          width: 1.5,
        ),
        primary: widget.backgroundColor,
        onPrimary: widget.textColor,
      ),
      child: widget.label == ""
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ),
            )
          : Text(widget.label,
              style: AppStyles.buttonText.copyWith(color: widget.textColor)),
    );
  }
}
