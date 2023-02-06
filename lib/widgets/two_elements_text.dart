import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hear_me/constants/app_color.dart';

class TwoElementsText extends StatelessWidget {
  const TwoElementsText({
    Key? key,
    this.leftText,
    this.buttonText,
    this.onTap,
  }) : super(key: key);

  final String? leftText;
  final String? buttonText;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(leftText != null ? leftText! : '',
          style: GoogleFonts.poppins(
            color: Colors.grey[400],
            fontSize: 14,
            fontWeight: FontWeight.w300,
          )),
      const SizedBox(width: 8),
      InkWell(
        onTap: () {
          if (onTap != null) {
            onTap!();
          }
        },
        child: Text(buttonText != null ? buttonText! : '',
            style: GoogleFonts.poppins(
              color: AppColors.primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            )),
      )
    ]);
  }
}
