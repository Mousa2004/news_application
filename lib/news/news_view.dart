import 'package:flutter/material.dart';
import 'package:news_application/apptheme.dart';
import 'package:news_application/model/source_model.dart';
import 'package:news_application/news/news_item.dart';
import 'package:news_application/news/tabBar_item.dart';

class NewsView extends StatefulWidget {
  final String categoryId;
  const NewsView({super.key, required this.categoryId});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<SourceModel> sources = List.generate(
      10,
      (index) => SourceModel(id: "$index", name: "ABC News $index"),
    );
    return Column(
      children: [
        DefaultTabController(
          length: sources.length,
          child: TabBar(
            onTap: (index) {
              if (currentIndex == index) return;
              currentIndex = index;
              setState(() {});
            },
            isScrollable: true,
            labelPadding: EdgeInsetsDirectional.only(start: 16),
            tabAlignment: TabAlignment.start,
            indicatorColor: Apptheme.white,
            dividerColor: Colors.transparent,
            tabs: sources
                .map(
                  (source) => TabbarItem(
                    text: source.name,
                    isSelect: currentIndex == sources.indexOf(source),
                  ),
                )
                .toList(),
          ),
        ),
        SizedBox(height: 16),
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) => NewsItem(),
            separatorBuilder: (context, index) => SizedBox(height: 16),
            itemCount: 7,
          ),
        ),
      ],
    );
  }
}
