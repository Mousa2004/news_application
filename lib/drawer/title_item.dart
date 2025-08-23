import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TitleItem extends StatelessWidget {
  final String icon;
  final String text;
  const TitleItem({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          "assets/icons/$icon.svg",
          height: 24,
          width: 24,
          fit: BoxFit.scaleDown,
        ),
        SizedBox(width: 8),
        Text(
          text,
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
