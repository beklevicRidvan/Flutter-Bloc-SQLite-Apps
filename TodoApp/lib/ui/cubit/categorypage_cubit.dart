import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_ornegim/data/entity/category_model.dart';
import 'package:todo_app_ornegim/data/repo/todo_app_dao_repository.dart';

class CategoryPageCubit extends Cubit<List<CategoryModel>>{
    CategoryPageCubit() : super (<CategoryModel>[]);

    final _todoDaoRepository = TodoDaoRepository();



    Future<void> loadwithMy() async {
      var categories = await _todoDaoRepository.loadCategoriesWithTaskCount();
      emit(categories);
    }

    

    }