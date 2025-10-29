import 'package:hive/hive.dart';
import 'package:news_application/sources/data/models/source.dart';
part 'article.g.dart';

@HiveType(typeId: 2)
class News extends HiveObject {
  @HiveField(0)
  Source? source;
  @HiveField(1)
  String? author;
  @HiveField(2)
  String? title;
  @HiveField(3)
  String? description;
  @HiveField(4)
  String? url;
  @HiveField(5)
  String? urlToImage;
  @HiveField(6)
  DateTime? publishedAt;
  @HiveField(7)
  String? content;

  News({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory News.fromJson(Map<String, dynamic> json) => News(
    source: json['source'] == null
        ? null
        : Source.fromJson(json['source'] as Map<String, dynamic>),
    author: json['author'] as String?,
    title: json['title'] as String?,
    description: json['description'] as String?,
    url: json['url'] as String?,
    urlToImage: json['urlToImage'] as String?,
    publishedAt: json['publishedAt'] == null
        ? null
        : DateTime.parse(json['publishedAt'] as String),
    content: json['content'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'source': source?.toJson(),
    'author': author,
    'title': title,
    'description': description,
    'url': url,
    'urlToImage': urlToImage,
    'publishedAt': publishedAt?.toIso8601String(),
    'content': content,
  };
}
