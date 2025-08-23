import 'package:flutter/material.dart';
import 'package:news_application/apptheme.dart';
import 'package:news_application/model/news_response/article.dart';
import 'package:news_application/news/news_details_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class ShowDetailsButton extends StatelessWidget {
  final News news;
  const ShowDetailsButton({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    Future<void> _launchUrl(String? link) async {
      if (link == null || link.isEmpty) return;
      final Uri url = Uri.parse(link);
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    }

    return Padding(
      padding: const EdgeInsetsDirectional.all(8.0),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsetsDirectional.all(8),
            margin: EdgeInsets.only(left: 10, right: 10),
            width: double.infinity,
            height: MediaQuery.sizeOf(context).height * 0.48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Apptheme.white),
              color: Apptheme.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    news.urlToImage ??
                        "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg",
                    height: MediaQuery.sizeOf(context).height * 0.3,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  textAlign: TextAlign.start,
                  news.title!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium!.copyWith(color: Apptheme.black),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 5,
            right: 21,
            left: 21,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      color: Apptheme.black,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => NewsDetailsScreen(news: news),
                          ),
                        );
                      },
                      child: Text(
                        "View Full Articel",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      color: Apptheme.black,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        _launchUrl(news.url);
                      },
                      child: Text(
                        textAlign: TextAlign.center,
                        "Browsing from Google",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
