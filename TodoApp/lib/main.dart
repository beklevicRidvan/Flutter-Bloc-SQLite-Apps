import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'ui/cubit/allcategorypage_cubit.dart';
import 'ui/cubit/categorypage_completed_cubit.dart';
import 'ui/cubit/categorypage_cubit.dart';
import 'ui/cubit/categorypage_dropdown_cubit.dart';
import 'ui/cubit/completedtodopage_cubit.dart';
import 'ui/cubit/dropdown_category_cubit.dart';
import 'ui/cubit/dropdown_category_pageshow_cubit.dart';
import 'ui/cubit/home_page_cubit.dart';
import 'ui/cubit/home_page_index_cubit.dart';
import 'ui/cubit/onlycategory_page_cubit.dart';
import 'ui/cubit/todopage_checkbox_cubit.dart';
import 'ui/cubit/todopage_cubit.dart';
import 'ui/cubit/uncompletedpage_cubit.dart';
import 'ui/views/home_page.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> TodoPageCubit()),
        BlocProvider(create: (context)=> CategoryPageCubit()),
        BlocProvider(create: (context)=> HomePageIndexCubit()),
        BlocProvider(create: (context)=> HomePageCubit()),
        BlocProvider(create: (context)=> DropdownCategoryCubit()),
        BlocProvider(create: (context)=> TodoPageCheckBoxCubit()),
        BlocProvider(create: (context)=> CategoryPageDropdownCubit()),
        BlocProvider(create: (context)=> CategoryPageCompletedTodoCubit()),
        BlocProvider(create: (context)=> CompletedTodoPageCubit()),
        BlocProvider(create: (context)=> UnCompletedPageCubit()),
        BlocProvider(create: (context)=> AllCategoryPageCubit()),
        BlocProvider(create: (context)=> OnlyCategoryPageCubit()),
        BlocProvider(create: (context)=> ShowDropDownCategoryCubit()),

      ],
      child: ScreenUtilInit(
        designSize:  const Size(393,786),
        builder: (context,_){

          return  MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.dark(),
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
