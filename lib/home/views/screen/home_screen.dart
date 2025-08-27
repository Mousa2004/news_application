import 'package:flutter/material.dart';
import 'package:news_application/categories/views/widget/category_view.dart';
import 'package:news_application/home/views/screen/drawer_home.dart';
import 'package:news_application/categories/data/models/category_model.dart';
import 'package:news_application/news/views/widget/news_view.dart';
import 'package:news_application/news/views/widget/search_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routName = "/home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CategoryModel? selectCategory;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectCategory == null ? "Home" : selectCategory!.name,
          style: textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(SearchScreen.routName);
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      drawer: DrawerHome(resetSelected: resetSelectedCategory),
      body: selectCategory == null
          ? CategoryView(categorySelected: onCategorySelected)
          : NewsView(categoryId: selectCategory!.id),
    );
  }

  void onCategorySelected(CategoryModel category) {
    selectCategory = category;
    setState(() {});
  }

  void resetSelectedCategory() {
    if (selectCategory == null) return;
    selectCategory = null;
    setState(() {});
  }
}
