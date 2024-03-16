import 'package:e_ticaret_uygulamasi/ui/cubit/allproducts_page_cubit.dart';
import 'package:e_ticaret_uygulamasi/ui/views/all_products_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/entity/category_model.dart';
import '../cubit/category_cubit.dart';
import '../cubit/home_page_bottomnavigationbar_cubit.dart';
import 'favorites_page.dart';
import 'shopping_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var keyAllProductsPage = const PageStorageKey("key_products_page");
  var keyFavoritesPage =const PageStorageKey("key_favorites_page");
  var keyShoppingPage = const PageStorageKey("key_shopping_page");

  late AllProductsPage allProductsPage;
  late FavoritesPage favoritesPage;
  late ShoppingPage shoppingPage;
  late List<Widget> pageList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CategoryCubit>().loadCategories();
    allProductsPage =  AllProductsPage(key: keyAllProductsPage);
    favoritesPage =  FavoritesPage(key: keyFavoritesPage,);
    shoppingPage =  ShoppingPage(key:keyShoppingPage,);
    pageList = [allProductsPage, favoritesPage, shoppingPage];
    context.read<CategoryCubit>().loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 20,
      shadowColor: Colors.black,
      toolbarHeight: 80,
      backgroundColor: Colors.grey.shade200.withOpacity(0.9),
      title: _buildAppBarTextFormField(),
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.mail_outline,
              size: 25,
            )),
        IconButton(
            onPressed: () {},
            style: IconButton.styleFrom(
                padding: const EdgeInsets.all(0),
                backgroundColor: Colors.deepOrange,
                shape: const CircleBorder()),
            icon: const Icon(
              Icons.notifications_none,
              color: Colors.white,
              size: 30,
            )),
      ],
      bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 50),
          child: Row(
            children: [

              /*ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder()),
                onPressed: () {
                  context
                      .read<AllProductPageCubit>()
                      .loadProducts();
                },
                child: const Text("Hepsi",
                  style:  TextStyle(color: Colors.black),),),*/
              Expanded(child: _buildFilteredRow())
            ],
          )),
    );
  }

  TextField _buildAppBarTextFormField() {
    return TextField(
      onChanged: (value) {
        context.read<AllProductPageCubit>().loadProducts(value: value);
      },
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(15),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none),
          prefixIcon: const Icon(
            Icons.search,
            size: 30,
          ),
          hintText: "Marka,ürün veya kategori ara"),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<HomePageBottomNavigationBarCubit, int>(
        builder: (context, index) {
      return pageList[index];
    });
  }

  Widget _buildFilteredRow() {
    return BlocBuilder<CategoryCubit, List<CategoryModel>>(
      builder: (context, categories) {

        List<String> allList = ["Hepsi",];

        for (var eleman in categories){
          allList.add(eleman.categoryName ?? "");
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
          ),
          child: ListView.builder(
              itemCount: allList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var currentCategory = allList[index];

                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder()),
                  onPressed: () {
                   if(index == 0 ){
                     context.read<AllProductPageCubit>().loadProducts();
                   }
                   else{
                     context
                         .read<AllProductPageCubit>()
                         .loadProducts(categoryId: index);

                   }
                  },
                  child: Text(
                    currentCategory,
                    style: const TextStyle(color: Colors.black),
                  ),
                );
              }),
        );
      },
    );
  }

  Widget _buildBottomNavigationBar() {
    return BlocBuilder<HomePageBottomNavigationBarCubit, int>(
      builder: (context, index) {
        return BottomNavigationBar(
            selectedItemColor: Colors.deepOrange,
            elevation: 10,
            iconSize: 30,
            type: BottomNavigationBarType.fixed,
            currentIndex: index,
            onTap: (selectedIndex) {
              context
                  .read<HomePageBottomNavigationBarCubit>()
                  .changeCurrentIndex(selectedIndex);
            },
            unselectedFontSize: 14,
            selectedFontSize: 18,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: "Anasayfa"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: "Favorilerim"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart), label: "Sepetim"),
            ]);
      },
    );
  }
}
