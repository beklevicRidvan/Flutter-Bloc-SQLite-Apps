import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/entity/todo_model.dart';
import '../../data/repo/todo_app_dao_repository.dart';

class CompletedTodoPageCubit extends Cubit<List<TodoModel>>{

  CompletedTodoPageCubit():super(<TodoModel>[]);

  final _todoDaoRepository = TodoDaoRepository();

  Future<void> loadCompletedAllTodos() async{

    var todos = await _todoDaoRepository.loadCompletedTodos();
    emit(todos);

  }

}