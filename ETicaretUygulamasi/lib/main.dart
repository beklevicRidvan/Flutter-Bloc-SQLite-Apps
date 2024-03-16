import 'package:e_ticaret_uygulamasi/ui/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'ui/cubit/category_cubit.dart';
import 'ui/cubit/favorites_page_cubit.dart';
import 'ui/cubit/home_page_bottomnavigationbar_cubit.dart';
import 'ui/cubit/allproducts_page_cubit.dart';
import 'ui/cubit/product_piece_cubit.dart';
import 'ui/cubit/shopping_page_cubit.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> CategoryCubit()),
        BlocProvider(create: (context)=> AllProductPageCubit()),
        BlocProvider(create: (context)=> HomePageBottomNavigationBarCubit()),
        BlocProvider(create: (context)=> FavoritesPageCubit()),
        BlocProvider(create: (context)=> ShoppingPageCubit()),
        BlocProvider(create: (context)=> ProductPieceCubit()),


      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
