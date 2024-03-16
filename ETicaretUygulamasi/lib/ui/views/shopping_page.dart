import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/entity/constants.dart';
import '../../data/entity/order_model.dart';
import '../cubit/shopping_page_cubit.dart';

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({super.key});

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ShoppingPageCubit>().loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShoppingPageCubit, List<OrderModel>>(
        builder: (context, orders) {
      if (orders.isNotEmpty) {
        return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              var currentOrder = orders[index];
              return _buildListItem(currentOrder);
            });
      } else {
        return const Center(
          child: Text(
            "Sepetiniz boş",
            style: TextStyle(fontSize: 20),
          ),
        );
      }
    });
  }

  Widget _buildListItem(OrderModel currentOrder) {
    return Card(
      margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
      child: ListTile(
          leading: CachedNetworkImage(
            imageUrl: currentOrder.orderImageAdress ??
                "currentOrder.orderImageAdress",
            progressIndicatorBuilder: (context, url, progress) => Center(
              child: CircularProgressIndicator(
                value: progress.progress,
              ),
            ),
            fit: BoxFit.contain,
          ),
          title: Text(currentOrder.orderName ?? "As"),
          subtitle: Text("${currentOrder.piece * currentOrder.orderPiece} TL"),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(tooltip: "Sepetten Kaldır",onPressed: (){
                context.read<ShoppingPageCubit>().deleteOrders(currentOrder.orderId);
                context.read<ShoppingPageCubit>().loadOrders();
              }, icon:const Icon(Icons.cancel_rounded)),
              Text(Constants.calculateDate(currentOrder.orderDate)),
            ],
          )),
    );
  }
}
