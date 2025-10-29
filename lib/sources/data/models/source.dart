import 'package:hive/hive.dart';
part 'source.g.dart';

@HiveType(typeId: 1)
class Source extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? description;
  @HiveField(3)
  String? url;
  @HiveField(4)
  String? category;
  @HiveField(5)
  String? language;
  @HiveField(6)
  String? country;

  Source({
    this.id,
    this.name,
    this.description,
    this.url,
    this.category,
    this.language,
    this.country,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
    id: json['id']?.toString(),
    name: json['name']?.toString(),
    description: json['description']?.toString(),
    url: json['url']?.toString(),
    category: json['category']?.toString(),
    language: json['language']?.toString(),
    country: json['country']?.toString(),
  );

  Map<String, dynamic> toJson() => {
    if (id != null) 'id': id,
    if (name != null) 'name': name,
    if (description != null) 'description': description,
    if (url != null) 'url': url,
    if (category != null) 'category': category,
    if (language != null) 'language': language,
    if (country != null) 'country': country,
  };
}
