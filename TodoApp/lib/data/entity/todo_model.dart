class TodoModel{
  int id;
  String description;
  bool isCompleted;
  int categoryID;
  String? categoryName;
  int? taskCount;


  TodoModel({required this.id,required this.description,required this.categoryID,this.isCompleted=false,this.categoryName,this.taskCount});
}