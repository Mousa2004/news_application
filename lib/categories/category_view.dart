import 'package:flutter/material.dart';
import 'package:news_application/categories/category_item.dart';
import 'package:news_application/model/category_model.dart';

class CategoryView extends StatelessWidget {
  final void Function(CategoryModel) categorySelected;
  const CategoryView({super.key, required this.categorySelected});

  @override
  Widget build(BuildContext context) {
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
                  categorySelected(CategoryModel.categories[index]);
                },
                child: CategoryItem(
                  imageName: CategoryModel.categories[index].imageName,
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(height: 16),
              itemCount: CategoryModel.categories.length,
            ),
          ),
        ],
      ),
    );
  }
}
