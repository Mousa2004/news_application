class CategoryModel {
  String id;
  String name;
  String imageName;
  CategoryModel({
    required this.id,
    required this.name,
    required this.imageName,
  });

  static List<CategoryModel> categories = [
    CategoryModel(
      id: 'general',
      name: "General",
      imageName: "assets/images/general.png",
    ),
    CategoryModel(
      id: 'business',
      name: "Business",
      imageName: "assets/images/business.png",
    ),
    CategoryModel(
      id: 'sports',
      name: "Sports",
      imageName: "assets/images/sport.png",
    ),
    CategoryModel(
      id: 'technology',
      name: "Technology",
      imageName: "assets/images/technology.png",
    ),
    CategoryModel(
      id: 'entertainment',
      name: "Entertainment",
      imageName: "assets/images/entertainment.png",
    ),
    CategoryModel(
      id: 'health',
      name: "Health",
      imageName: "assets/images/health.png",
    ),
    CategoryModel(
      id: 'science',
      name: "Science",
      imageName: "assets/images/science.png",
    ),
  ];
}
