import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_ornegim/data/repo/todo_app_dao_repository.dart';
import '../../data/entity/todo_model.dart';

class TodoPageCubit extends Cubit<List<TodoModel>>{

  TodoPageCubit() : super(<TodoModel>[]);

  final _todoDaoRepository = TodoDaoRepository();

  Future<void> loadTodos() async{
    var todos = await _todoDaoRepository.loadTodos();
    emit(todos);
  }

  Future<void> getTasksByCategory(int categoryId) async {
    var todos = await _todoDaoRepository.getTasksByCategory(categoryId);
    emit(todos);
  }

    Future<void> deleteTodo(int todoId) async{
    await _todoDaoRepository.deleteTodo(todoId);

  }

  Future<void> updateTodo(int todoId,String newDescription,int newCategoryID)async{
    await _todoDaoRepository.updateTodo(todoId, newDescription, newCategoryID);

  }

  Future<int> getTaskCountForCategory(int categoryId) async {
    // Kategoriye ait görev sayısını veritabanından al
    List<TodoModel> tasks = await _todoDaoRepository.getTasksByCategory(categoryId);
    return tasks.length;
  }






    Future<void> changeTodoCheckValue(int todoID, bool isCompleted,TodoModel currentElement) async {
    // Veritabanında durumu güncelle
    await _todoDaoRepository.changeCompletedValue(todoID, isCompleted,currentElement);


    // Yeni durumu getir
    var updatedTodos = await _todoDaoRepository.loadTodos();

    // Durumu emit ile güncelle
    emit(updatedTodos);
  }






}