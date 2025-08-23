import 'package:flutter/material.dart';

class TabbarItem extends StatelessWidget {
  final String text;
  final bool isSelect;

  const TabbarItem({super.key, required this.text, required this.isSelect});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Text(
      text,
      style: isSelect ? textTheme.titleMedium : textTheme.titleSmall,
    );
  }
}
