import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/entity/category_model.dart';
import '../../data/repo/e_commerce_dao_repository.dart';

class CategoryCubit extends Cubit<List<CategoryModel>>{

  CategoryCubit():super(<CategoryModel>[]);

  final _eRepo = ECommerceDaoRepository();

  Future<void> loadCategories() async{
    var categories = await _eRepo.loadCategories();

    emit(categories);
  }

}