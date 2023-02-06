import 'package:flutter/material.dart';
import 'package:hear_me/constants/app_styles.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.size,
    this.icon = const Icon(
      Icons.arrow_back_outlined,
      size: 28,
    ),
    required this.onTap,
    this.title,
    this.fontSize = 20,
    this.actions = const <Widget>[],
  }) : super(key: key);

  final Size size;
  final Widget icon;
  final String? title;
  final int fontSize;
  final Function onTap;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height,
      width: size.width,
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          InkWell(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 16, 16),
                child: icon,
              ),
              onTap: () => onTap()),
          if (title != null)
            Text(title!,
                style: AppStyles.headerText
                    .copyWith(fontSize: fontSize.toDouble())),
          const Spacer(),
          ...actions,
        ],
      ),
    );
  }
}
