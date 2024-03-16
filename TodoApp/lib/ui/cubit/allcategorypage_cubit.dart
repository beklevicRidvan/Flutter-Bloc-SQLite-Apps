import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/entity/category_model.dart';
import '../../data/repo/todo_app_dao_repository.dart';

class AllCategoryPageCubit extends Cubit<List<CategoryModel>>{
  AllCategoryPageCubit() : super(<CategoryModel>[]);


  final _todoDaoRepository = TodoDaoRepository();

  Future<void> loadCategories() async {
    var categories = await _todoDaoRepository.loadCategories();
    emit(categories);
  }

  Future<void> deleteCategory(int categoryId) async{
    var rowCount = await _todoDaoRepository.deleteCategory(categoryId);
    debugPrint(rowCount.toString());
  }

}