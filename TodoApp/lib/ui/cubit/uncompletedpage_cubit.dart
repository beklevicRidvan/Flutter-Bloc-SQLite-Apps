import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/entity/todo_model.dart';
import '../../data/repo/todo_app_dao_repository.dart';

class UnCompletedPageCubit extends Cubit<List<TodoModel>>{

  UnCompletedPageCubit():super(<TodoModel>[]);

  final _todoDaoRepository = TodoDaoRepository();

  Future<void> loadUnCompletedTodos() async{
    var todos = await _todoDaoRepository.loadUnCompletedTodos();
    emit(todos);

  }
}