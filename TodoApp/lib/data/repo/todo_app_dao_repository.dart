
import 'package:flutter/widgets.dart';

import '../../sqlite/database_helper.dart';
import '../entity/category_model.dart';
import '../entity/todo_model.dart';

class TodoDaoRepository{


  String _categoryTableName = "category";
  String _todoTableName = "todo";


  Future<List<CategoryModel>> loadCategoriesWithTaskCount() async {
    var _db = await DatabaseHelper.veritabaniErisim();

    // Görev sayısı 0'dan büyük olan kategorileri seç
    List<Map<String, dynamic>> result = await _db.rawQuery('''
    SELECT category.*, COUNT(todo.id) AS taskCount
    FROM category
    LEFT JOIN todo ON category.categoryID = todo.categoryID
    GROUP BY category.categoryID
    HAVING COUNT(todo.id) > 0
  ''');

    return List<CategoryModel>.generate(result.length, (index) {
      var row = result[index];
      return CategoryModel(
        categoryID: row['categoryID'],
        categoryName: row['categoryName'],
        taskCount: row['taskCount'],
      );
    });
  }

  Future<int> loadCompletedTaskCountForCategory(int categoryId) async {
    var _db = await DatabaseHelper.veritabaniErisim();

    // Belirli bir kategoride tamamlanmış görev sayısını getir
    List<Map<String, dynamic>> result = await _db.rawQuery('''
    SELECT COUNT(todo.id) AS completedTaskCount
    FROM category
    LEFT JOIN todo ON category.categoryID = todo.categoryID
    WHERE category.categoryID = ?
      AND todo.isCompleted = 1
  ''', [categoryId]);

    if (result.isNotEmpty) {
      var row = result.first;
      return row['completedTaskCount'];
    } else {
      return 0;
    }
  }


/*
  Future<List<CategoryModel>> loadCategoriesWithCompletedTaskCount() async {
  var _db = await DatabaseHelper.veritabaniErisim();

  // Görev sayısı 0'dan büyük olan kategorileri seç
  List<Map<String, dynamic>> result = await _db.rawQuery('''
  SELECT category.*, COUNT(todo.id) AS taskCount
  FROM category
  LEFT JOIN todo ON category.categoryID = todo.categoryID
  WHERE todo.isCompleted = 1
  GROUP BY category.categoryID
  HAVING COUNT(todo.id) > 0
''');

  return List<CategoryModel>.generate(result.length, (index) {
  var row = result[index];
  return CategoryModel(
  categoryID: row['categoryID'],
  categoryName: row['categoryName'],
  taskCount: row['taskCount'],
  );
  });
  }


 */

  Future<int> getCompletedTaskCount() async {
    var _db = await DatabaseHelper.veritabaniErisim();
    var todos = await _db.query('todo');

    int completedTaskCount = 0;
    for (var todo in todos) {
      if (todo['isCompleted'] == 1) {
        completedTaskCount++;
      }
    }

    return completedTaskCount;
  }




  Future<List<TodoModel>> loadTodos() async {
    var _db = await DatabaseHelper.veritabaniErisim();

    List<Map<String, dynamic>> maps = await _db.rawQuery(
        "SELECT todo.id, todo.description, todo.isCompleted, todo.categoryID, category.categoryName " +
            "FROM todo " +
            "JOIN category ON todo.categoryID = category.categoryID"
    );

    return List.generate(maps.length, (index) {
      var row = maps[index];
      return TodoModel(
        id: row["id"],
        description: row["description"],
        isCompleted: row["isCompleted"] == 1,
        categoryID: row["categoryID"],
        categoryName: row["categoryName"],
      );
    });
  }


  Future<List<TodoModel>> loadCategoryTodos(int categoryId) async {
    var _db = await DatabaseHelper.veritabaniErisim();

    List<Map<String, dynamic>> maps = await _db.rawQuery('''
    SELECT todo.id, todo.description, todo.isCompleted, todo.categoryID, category.categoryName
    FROM todo
    JOIN category ON todo.categoryID = category.categoryID
    WHERE todo.categoryID = $categoryId
  ''');

    return List.generate(maps.length, (index) {
      var row = maps[index];
      return TodoModel(
        id: row["id"],
        description: row["description"],
        isCompleted: row["isCompleted"] == 1,
        categoryID: row["categoryID"],
        categoryName: row["categoryName"],
      );
    });
  }


  Future<List<TodoModel>> loadCompletedTodos() async {
    var _db = await DatabaseHelper.veritabaniErisim();

    List<Map<String, dynamic>> maps = await _db.rawQuery(
        "SELECT todo.id, todo.description, todo.isCompleted, todo.categoryID, category.categoryName " +
            "FROM todo " +
            "JOIN category ON todo.categoryID = category.categoryID " +
            "WHERE todo.isCompleted = 1"
    );
    return List.generate(maps.length, (index) {
      var row = maps[index];
      return TodoModel(
        id: row["id"],
        description: row["description"],
        isCompleted: row["isCompleted"] == 1,
        categoryID: row["categoryID"],
        categoryName: row["categoryName"],
      );
    });
  }


  Future<List<TodoModel>> loadUnCompletedTodos() async {
    var _db = await DatabaseHelper.veritabaniErisim();

    List<Map<String, dynamic>> maps = await _db.rawQuery(
        "SELECT todo.id, todo.description, todo.isCompleted, todo.categoryID, category.categoryName " +
            "FROM todo " +
            "JOIN category ON todo.categoryID = category.categoryID " +
            "WHERE todo.isCompleted = 0"
    );
    return List.generate(maps.length, (index) {
      var row = maps[index];
      return TodoModel(
        id: row["id"],
        description: row["description"],
        isCompleted: row["isCompleted"] == 1,
        categoryID: row["categoryID"],
        categoryName: row["categoryName"],
      );
    });
  }






  Future<List<TodoModel>> getTasksByCategory(int categoryId) async {
    var _db = await DatabaseHelper.veritabaniErisim();

    final List<Map<String, dynamic>> maps = await _db.query(
      '$_todoTableName',
      where: 'categoryId = ?',
      whereArgs: [categoryId],
    );

    return List.generate(maps.length, (index)  {
      var row = maps[index];
      return TodoModel(id: row["id"],description: row["description"],  isCompleted: row["isCompleted"] == 1, // 1 ise true, 0 ise false
          categoryID: row["categoryID"]);
    });
  }




  Future<void> changeCompletedValue(int todoID, bool isCompletedd,TodoModel currentElement) async {
    var _db = await DatabaseHelper.veritabaniErisim();

    int rowCount = await _db.rawUpdate(
      'UPDATE $_todoTableName SET isCompleted = ? WHERE id = ?',
      [isCompletedd ? 1 : 0, todoID],
    );


    debugPrint('Row count: $rowCount');

  }

  Future<List<CategoryModel>> loadCategories() async{
   var _db = await DatabaseHelper.veritabaniErisim();

   List<Map<String,dynamic>> maps = await _db.rawQuery("SELECT * FROM category");

   return List.generate(maps.length, (index) {
     var row = maps[index];
     return CategoryModel(categoryID: row["categoryID"], categoryName: row["categoryName"]);
   });



  }

  Future<void> createCategory(String categoryName) async {
    var _db = await DatabaseHelper.veritabaniErisim();
    var newCategory = Map<String,dynamic>();
    newCategory["categoryName"] = categoryName;

    await _db.insert(_categoryTableName, newCategory);

  }

  Future<void> createTask(String description,int categoryID) async {
    var _db = await DatabaseHelper.veritabaniErisim();
    var newTask = Map<String,dynamic>();
    newTask["description"] = description;
    newTask["categoryID"] = categoryID;

    await _db.insert(_todoTableName, newTask);

  }
  
  Future<void> deleteTodo(int todoId) async{
    var _db = await DatabaseHelper.veritabaniErisim();
    int rowCount = await _db.delete(_todoTableName,where: "id = ?",whereArgs: [todoId]);

    debugPrint(rowCount.toString());
  }

  Future<int> deleteCategory(int categoryId) async{
    var _db = await DatabaseHelper.veritabaniErisim();
    int rowCount = await _db.delete(_categoryTableName,where: "categoryID = ?",whereArgs: [categoryId]);
    return rowCount;
  }

  Future<void> updateTodo(int todoId,String newDescription,int newCategoryID)async{
    var _db = await DatabaseHelper.veritabaniErisim();
    var updatedTask = Map<String,dynamic>();

    updatedTask["description"] = newDescription;
    updatedTask["categoryID"] = newCategoryID;
   int rowCount =  await _db.update(_todoTableName, updatedTask,where: "id = ?",whereArgs: [todoId]);

   debugPrint(rowCount.toString());
  }



}