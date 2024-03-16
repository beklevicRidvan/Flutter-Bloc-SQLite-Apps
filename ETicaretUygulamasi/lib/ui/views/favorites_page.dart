import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/entity/favorite_model.dart';
import '../cubit/favorites_page_cubit.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FavoritesPageCubit>().loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesPageCubit, List<FavoriteModel>>(
        builder: (context, products) {
      if (products.isNotEmpty) {
        return GridView.builder(
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, mainAxisExtent: 200),
            itemBuilder: (context, index) {
              var currentElement = products[index];
              return _buildListItem(currentElement);
            });
      } else {
        return const Center(
          child: Text(
            "Favorileriniz Boş",
            style: TextStyle(fontSize: 25),
          ),
        );
      }
    });
  }

  Widget _buildListItem(FavoriteModel currentElement) {
    return Card(
      child: Stack(children: [
        _buildFavoriteRow(currentElement),
        Positioned(
          top: 0,
          right: 0,
          child: PopupMenuButton(
            iconSize: 35,
            tooltip: "Düzenle",
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                    onTap: () {
                      context
                          .read<FavoritesPageCubit>()
                          .deleteFavorite(currentElement.favoritesId);

                      context.read<FavoritesPageCubit>().loadFavorites();
                    },
                    child: const InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.delete),
                          Text(
                            "Sil",
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          )
                        ],
                      ),
                    ))
              ];
            },
          ),
        ),
        Positioned(
            right: 0,
            bottom: 0,
            child: TextButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.orange,
                    shape: const RoundedRectangleBorder()),
                onPressed: () {},
                child: const Text(
                  "Sepete Ekle",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ))),
      ]),
    );
  }

  Row _buildFavoriteRow(FavoriteModel currentElement) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          width: 200,
          child: CachedNetworkImage(
            imageUrl:
                currentElement.imageAdress ?? "currentOrder.orderImageAdress",
            progressIndicatorBuilder: (context, url, progress) => Center(
              child: CircularProgressIndicator(
                value: progress.progress,
              ),
            ),
            fit: BoxFit.contain,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              currentElement.productName!.split(" ").first,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

          ],
        )
      ],
    );
  }
}
