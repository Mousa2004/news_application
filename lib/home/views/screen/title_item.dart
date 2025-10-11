import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_application/shared/view/widget/apptheme.dart';

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
          height: 24.h,
          width: 24.w,
          fit: BoxFit.scaleDown,
        ),
        SizedBox(width: 8.w),
        Text(
          text,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w700,
            color: Apptheme.white,
          ),
        ),
      ],
    );
  }
}
