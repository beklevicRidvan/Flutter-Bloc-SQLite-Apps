import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/entity/product_model.dart';
import '../../data/repo/e_commerce_dao_repository.dart';

class AllProductPageCubit extends Cubit<List<ProductModel>>{

  AllProductPageCubit(): super(<ProductModel>[]);


  final _eRepo = ECommerceDaoRepository();

  void loadProducts({int? categoryId,String? value}) async {
    if (categoryId != null) {
      var products = await _eRepo.getAllProductsByCategoryId(categoryId);
      emit(products);
    }
    else if(value != null){
      var products = await _eRepo.wantedProducts(value);
      emit(products);
    }
    else {
      var products = await _eRepo.loadProducts();
      emit(products);
    }
  }


}