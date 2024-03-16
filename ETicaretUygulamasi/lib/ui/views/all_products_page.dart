import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../data/entity/constants.dart';
import '../../data/entity/favorite_model.dart';
import '../../data/entity/product_model.dart';
import '../cubit/allproducts_page_cubit.dart';
import '../cubit/favorites_page_cubit.dart';
import '../cubit/shopping_page_cubit.dart';
import 'productdetail_page.dart';

class AllProductsPage extends StatefulWidget {
  const AllProductsPage({super.key});

  @override
  State<AllProductsPage> createState() => _AllProductsPageState();
}

class _AllProductsPageState extends State<AllProductsPage> {
  Set<int> favoritesList = {};
  // _AllProductsPageState içinde
// _AllProductsPageState içinde



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AllProductPageCubit>().loadProducts();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllProductPageCubit, List<ProductModel>>(
      builder: (context, products) {
        if (products.isNotEmpty) {
          return GridView.builder(
            itemCount: products.length,
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 20, mainAxisExtent: 300),
            itemBuilder: (context, index) {
              var currentProduct = products[index];
              return _buildListItem(currentProduct);
            },
          );
        } else {
          return const Center(child: Text("Ürünler Bulunamadı"));
        }
      },
    );
  }

  Widget _buildListItem(ProductModel currentProduct) {
    return InkWell(
      key: PageStorageKey("${currentProduct.productId}"),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetailPage(currentProduct: currentProduct,)));
      },
      child: Card(
        elevation: 15,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                    imageUrl: currentProduct.imageAdress,
                    width: 200,
                    height: 200,
                    progressIndicatorBuilder: (context, url, progress) =>
                        Center(
                          child: CircularProgressIndicator(
                            value: progress.progress,
                          ),
                        ),
                    fit: BoxFit.contain,
                  ),
                ),
                Text(
                  currentProduct.productName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "${currentProduct.price.toString()} TL",
                      style: TextStyle(
                          color: Constants.orangeColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    IconButton(
                      style: IconButton.styleFrom(
                          shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        context.read<ShoppingPageCubit>().addOrders(currentProduct.productId, 1, 1, DateTime.now().toString());
                      },
                      icon: const Icon(
                        Icons.add_shopping_cart,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ],
            ),
            BlocBuilder<FavoritesPageCubit, List<FavoriteModel>>(
              builder: (context, state) {
                return Positioned(

                  top: 0,
                  right: 0,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        if (favoritesList.contains(currentProduct.productId)) {
                          favoritesList.remove(currentProduct.productId);
                          context.read<FavoritesPageCubit>().deleteFavoriteByProductId(currentProduct.productId);


                        } else {
                          favoritesList.add(currentProduct.productId);
                          context.read<FavoritesPageCubit>().addFavorite(currentProduct.productId, 1);

                        }
                      });
                    },
                    icon: favoritesList.contains(currentProduct.productId)
                        ? Icon(
                      key: PageStorageKey(currentProduct.kategoriId),

                      Icons.favorite,
                      color: Colors.deepOrange,
                    )
                        : const Icon(Icons.favorite_border),
                    style:
                    IconButton.styleFrom(backgroundColor: Colors.grey.shade100),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
