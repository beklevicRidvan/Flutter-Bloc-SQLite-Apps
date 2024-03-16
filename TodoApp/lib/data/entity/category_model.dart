class CategoryModel{
  int categoryID;
  String categoryName;
  int? taskCount;

  CategoryModel({required this.categoryID,required this.categoryName,this.taskCount});
}