import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/entity/favorite_model.dart';
import '../../data/repo/e_commerce_dao_repository.dart';

class FavoritesPageCubit extends Cubit<List<FavoriteModel>>{
  FavoritesPageCubit():super(<FavoriteModel> []);



  final _eRepo = ECommerceDaoRepository();

  Future<void> loadFavorites() async{

    var categories = await _eRepo.loadMyFavorites();
    emit(categories);

  }

  Future<void> addFavorite(int productId,int customerId,{String? productName,
    String? imageAdress}) async{
     await _eRepo.addFavorite(productId, customerId,productName: productName,imageAdress: imageAdress);
  }

  Future<void> deleteFavorite(int favoriId) async{
    await _eRepo.deleteFavorite(favoriId);
  }

  Future<void> deleteFavoriteByProductId(int productId) async{
    await _eRepo.deleteFavoriteByProductId(productId);
  }


}