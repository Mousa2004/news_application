class Source {
  String? id;
  String? name;
  String? description;
  String? url;
  String? category;
  String? language;
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
