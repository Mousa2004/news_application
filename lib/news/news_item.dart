import 'package:flutter/material.dart';

import 'package:news_application/apptheme.dart';
import 'package:news_application/model/news_response/article.dart';
import 'package:news_application/provider/setting_theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsItem extends StatelessWidget {
  final News news;
  const NewsItem({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    SettingThemeProvider settingThemeProvider =
        Provider.of<SettingThemeProvider>(context);
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(left: 16, right: 16),
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * 0.37,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: settingThemeProvider.isLight ? Apptheme.black : Apptheme.white,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              news.urlToImage ??
                  "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg",
              height: MediaQuery.sizeOf(context).height * 0.25,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: 10),
          Text(
            news.title!,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "By : ${news.author}",

                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Text(
                timeago.format(news.publishedAt!),
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
