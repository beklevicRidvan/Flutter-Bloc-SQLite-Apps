import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/entity/order_model.dart';
import '../../data/repo/e_commerce_dao_repository.dart';

class ShoppingPageCubit extends Cubit<List<OrderModel>>{
  ShoppingPageCubit() : super (<OrderModel>[]);


  final _eRepo = ECommerceDaoRepository();

  Future<void> loadOrders() async{

    var orders = await _eRepo.loadMyOrders();
    emit(orders);
  }

  Future<void> addOrders(int productId,int customerId,int orderPiece,String orderDate) async{
    await _eRepo.addOrder(productId, customerId, orderPiece, orderDate);
  }

  Future<void> deleteOrders(int orderId)async{
    await _eRepo.deleteOrder(orderId);
  }
}