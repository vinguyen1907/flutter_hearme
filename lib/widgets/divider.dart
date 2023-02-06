import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({
    Key? key,
    required this.size,
    this.label,
  }) : super(key: key);

  final Size size;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.02,
      width: size.width * 0.8,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                  height: 1,
                  color: Colors.grey[300],
                  margin: const EdgeInsets.only(right: 12)),
            ),
            Text(label ?? '',
                style: GoogleFonts.poppins(
                  color: Colors.grey[700],
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1,
                )),
            Expanded(
              child: Container(
                  height: 1,
                  color: Colors.grey[300],
                  margin: const EdgeInsets.only(left: 12)),
            ),
          ]),
    );
  }
}
