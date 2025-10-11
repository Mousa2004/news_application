import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_application/shared/view/widget/apptheme.dart';
import 'package:news_application/news/data/models/article.dart';
import 'package:news_application/shared/view_model/setting_theme.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsItem extends StatelessWidget {
  final News news;
  const NewsItem({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    SettingTheme settingThemeProvider = Provider.of<SettingTheme>(context);
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(left: 16, right: 16),
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * 0.37.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: settingThemeProvider.isLight ? Apptheme.black : Apptheme.white,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: CachedNetworkImage(
              imageUrl:
                  news.urlToImage ??
                  "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg",
              errorWidget: (context, url, error) =>
                  Image.asset('assets/images/no_image.png', fit: BoxFit.cover),
              height: MediaQuery.sizeOf(context).height * 0.25.h,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: 10.h),
          Expanded(
            child: Text(
              news.title!,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          SizedBox(height: 10.h),
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
              SizedBox(width: 8.w),
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
