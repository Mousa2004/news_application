import 'package:flutter/material.dart';
import 'package:news_application/categories/views/widget/category_item.dart';
import 'package:news_application/categories/data/models/category_model.dart';
import 'package:news_application/shared/view_model/setting_theme.dart';
import 'package:provider/provider.dart';

class CategoryView extends StatelessWidget {
  final void Function(CategoryModel) categorySelected;
  const CategoryView({super.key, required this.categorySelected});

  @override
  Widget build(BuildContext context) {
    SettingTheme settingThemeProvider = Provider.of<SettingTheme>(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Good Morning\nHere is Some News For You",
            style: textTheme.headlineSmall,
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  categorySelected(
                    settingThemeProvider.isLight
                        ? CategoryModel.categoriesDark[index]
                        : CategoryModel.categoriesLight[index],
                  );
                },
                child: CategoryItem(
                  imageName: settingThemeProvider.isLight
                      ? CategoryModel.categoriesDark[index].imageName
                      : CategoryModel.categoriesLight[index].imageName,
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(height: 16),
              itemCount: settingThemeProvider.isLight
                  ? CategoryModel.categoriesDark.length
                  : CategoryModel.categoriesLight.length,
            ),
          ),
        ],
      ),
    );
  }
}
