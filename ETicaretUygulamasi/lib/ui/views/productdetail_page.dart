import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/entity/product_model.dart';
import '../cubit/product_piece_cubit.dart';
import '../cubit/shopping_page_cubit.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductModel currentProduct;

  const ProductDetailPage({super.key, required this.currentProduct});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomSheet: _buildBottomSheet(currentProduct, context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(currentProduct.productName),
      actions: [
        Stack(
          children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  size: 30,
                )),
            BlocBuilder<ProductPieceCubit, int>(
              builder: (context, state) {
                return Positioned(
                    top: 0,
                    right: 0,
                    child: Visibility(
                        visible: state > 0 ,
                        child: CircleAvatar(
                          radius: 10,
                          foregroundColor: Colors.deepOrange,
                          child: Text(state.toString()),
                        )));
              },
            )
          ],
        ),
        const SizedBox(
          width: 30,
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Container(
      alignment: Alignment.center,
      child: Card(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CachedNetworkImage(
              imageUrl: currentProduct.imageAdress,
              fit: BoxFit.fitWidth,
            ),
            const SizedBox(height: 20),
            Padding(
              padding:const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Text(
                      currentProduct.productName,
                      style: const TextStyle(fontSize:  16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  BlocBuilder<ProductPieceCubit, int>(
                    builder: (context, value) {
                      return Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(30)),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  context.read<ProductPieceCubit>().reduce(value);
                                },
                                icon:  Icon(CupertinoIcons.minus,
                                    color:value == 0 ? Colors.grey: Colors.deepOrange)),
                            CircleAvatar(
                              backgroundColor: Colors.deepOrange.shade100.withOpacity(0.4),
                              child: Text(
                                value.toString(),
                                style: const TextStyle(color: Colors.deepOrange),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  context
                                      .read<ProductPieceCubit>()
                                      .increase(value);
                                },
                                icon:  const Icon(
                                  CupertinoIcons.add,

                                  color: Colors.deepOrange,
                                )),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildBottomSheet(ProductModel currentProduct, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0),
          gradient: LinearGradient(colors: [
            Colors.deepOrange.shade200,
            Colors.brown.shade200,
            Colors.deepOrange.shade200,
          ])),
      child:  BlocBuilder<ProductPieceCubit, int>(
        builder: (context, state)  {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(

            "${currentProduct.price * state} TL",
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        side: BorderSide(color: Colors.deepOrange, width: 3))),
                onPressed: () {},
                child: const Text("Şimdi Al",
                    style: TextStyle(
                        color: Colors.deepOrange, fontWeight: FontWeight.bold)),
              ),
             
                   ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        shape: const RoundedRectangleBorder()),
                    onPressed: () {
                     if(state>0){
                       context.read<ShoppingPageCubit>().addOrders(currentProduct.productId, 1, state,DateTime.now().toString());
                       Navigator.pop(context);
                     }

                    },
                    child: const Text(
                      "Sepete Ekle",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                
              
            ],
          ),
        ],
      );
  },
),
    );
  }
}
