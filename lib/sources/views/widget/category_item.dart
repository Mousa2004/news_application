import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String imageName;
  const CategoryItem({super.key, required this.imageName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * 0.25,
      clipBehavior: Clip.antiAlias,
      child: Image.asset(imageName, fit: BoxFit.fill),
    );
  }
}
