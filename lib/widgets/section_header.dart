import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hear_me/constants/dimensions.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    Key? key,
    required this.title,
    this.actions = const <Widget>[],
  }) : super(key: key);

  final String title;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(Dimensions.mediumHorizontalMargin, 10,
          Dimensions.mediumHorizontalMargin, 0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(title,
            style:
                GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600)),
        ...actions,
      ]),
    );
  }
}
