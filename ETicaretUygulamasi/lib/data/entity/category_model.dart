class CategoryModel {
  final int id;
  final String? categoryName;

  CategoryModel({required this.id, this.categoryName});

  factory CategoryModel.fromId(int id) {
    return CategoryModel(id: id);
  }
}
