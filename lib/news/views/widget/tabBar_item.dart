import 'package:flutter/material.dart';
import 'package:news_application/sources/data/models/source.dart';

class TabbarItem extends StatelessWidget {
  final Source source;
  final bool isSelect;

  const TabbarItem({super.key, required this.source, required this.isSelect});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Text(
      source.name ?? "",
      style: isSelect ? textTheme.titleMedium : textTheme.titleSmall,
    );
  }
}
