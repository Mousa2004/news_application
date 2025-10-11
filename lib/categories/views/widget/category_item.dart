import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryItem extends StatelessWidget {
  final String imageName;
  const CategoryItem({super.key, required this.imageName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r)),
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * 0.25.h,
      clipBehavior: Clip.antiAlias,
      child: Image.asset(imageName, fit: BoxFit.fill),
    );
  }
}
