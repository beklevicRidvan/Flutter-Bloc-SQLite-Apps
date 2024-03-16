import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_ornegim/data/repo/todo_app_dao_repository.dart';

class HomePageCubit extends Cubit<void>{
  HomePageCubit():super(0);
  final  _todoDaoRepository = TodoDaoRepository();

  Future<void> createCategory(String categoryName)async{
    await _todoDaoRepository.createCategory(categoryName);
  }
  Future<void> createTask(String description,int categoryID)async{
    await _todoDaoRepository.createTask(description,categoryID);
  }
}