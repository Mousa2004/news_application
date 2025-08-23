import 'package:flutter/material.dart';
import 'package:news_application/apptheme.dart';
import 'package:news_application/drawer/drawer_home.dart';
import 'package:news_application/home_screen.dart';
import 'package:news_application/model/category_model.dart';
import 'package:news_application/model/news_response/article.dart';

import 'package:timeago/timeago.dart' as timeago;

class NewsDetailsScreen extends StatefulWidget {
  final News news;
  const NewsDetailsScreen({super.key, required this.news});

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  CategoryModel? selectCategory;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Apptheme.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Apptheme.black),
        backgroundColor: Apptheme.white,
        centerTitle: false,
        title: Text("${widget.news.source!.name}"),
      ),
      drawer: DrawerHome(
        onTap: () {
          Navigator.of(context).pushReplacementNamed(HomeScreen.routName);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            Text(
              widget.news.title!,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall!.copyWith(color: Apptheme.black),
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "By ",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Apptheme.grey,
                  ),
                ),

                Expanded(
                  child: Text(
                    widget.news.author ?? "Unknown",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.blue,
                      decorationThickness: 2,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              widget.news.publishedAt != null
                  ? timeago.format(widget.news.publishedAt!)
                  : "Unknown date",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.bold,
                color: Apptheme.grey,
              ),
            ),

            SizedBox(height: 40),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                widget.news.urlToImage ??
                    "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg",
                height: MediaQuery.sizeOf(context).height * 0.3,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 40),
            Text(
              widget.news.description!,
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(color: Apptheme.black),
            ),
            SizedBox(height: 20),
            Text(
              widget.news.content ?? "",
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(color: Apptheme.black),
            ),
          ],
        ),
      ),
    );
  }
}
