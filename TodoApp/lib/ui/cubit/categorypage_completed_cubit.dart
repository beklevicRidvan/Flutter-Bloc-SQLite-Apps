import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repo/todo_app_dao_repository.dart';

class CategoryPageCompletedTodoCubit extends Cubit<int>{
  CategoryPageCompletedTodoCubit():super(0);

  final _todoDaoRepository = TodoDaoRepository();

  Future<int> loadCategoriesWithCompletedTaskCount(int categoryID) async {
    var categories = await _todoDaoRepository.loadCompletedTaskCountForCategory(categoryID);
    return categories;

  }


  }