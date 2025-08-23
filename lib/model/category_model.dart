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
      id: '',
      name: "General",
      imageName: "assets/images/general_dark.png",
    ),
    CategoryModel(
      id: '',
      name: "Business",
      imageName: "assets/images/business_dark.png",
    ),
    CategoryModel(
      id: '',
      name: "Sports",
      imageName: "assets/images/sport_dark.png",
    ),
    CategoryModel(
      id: '',
      name: "Technology",
      imageName: "assets/images/technology_dark.png",
    ),
    CategoryModel(
      id: '',
      name: "Entertainment",
      imageName: "assets/images/entertainment_dark.png",
    ),
    CategoryModel(
      id: '',
      name: "Health",
      imageName: "assets/images/health_dark.png",
    ),
    CategoryModel(
      id: '',
      name: "Science",
      imageName: "assets/images/science_dark.png",
    ),
  ];
}
