import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/entity/todo_model.dart';
import '../../data/repo/todo_app_dao_repository.dart';

class OnlyCategoryPageCubit extends Cubit<List<TodoModel>>{
  OnlyCategoryPageCubit():super(<TodoModel>[]);


  final _todoDaoRepository = TodoDaoRepository();

  Future<void> getTodosByCategoryId (int categoryId) async {

    var todos = await _todoDaoRepository.loadCategoryTodos(categoryId);
    emit(todos);
  }
}