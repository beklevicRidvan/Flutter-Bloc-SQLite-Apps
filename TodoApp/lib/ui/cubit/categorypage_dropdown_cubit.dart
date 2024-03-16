import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_ornegim/data/entity/category_model.dart';

import '../../data/repo/todo_app_dao_repository.dart';

class CategoryPageDropdownCubit extends Cubit<List<CategoryModel>>{
  CategoryPageDropdownCubit() : super(<CategoryModel>[]);


  final _todoDaoRepository = TodoDaoRepository();

  Future<void> loadCategories() async {
    var categories = await _todoDaoRepository.loadCategories();
    emit(categories);
  }

}