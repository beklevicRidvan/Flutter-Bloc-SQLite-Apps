import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_ornegim/data/entity/category_model.dart';
import 'package:todo_app_ornegim/data/repo/todo_app_dao_repository.dart';

class ShowDropDownCategoryCubit extends Cubit<List<CategoryModel>>{
  ShowDropDownCategoryCubit() : super (<CategoryModel>[]);

  final _todoDaoRepository = TodoDaoRepository();



  Future<void> loadwithCategory() async {
    var categories = await _todoDaoRepository.loadCategories();
    emit(categories);
  }



}