import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app_ornegim/data/entity/category_model.dart';
import 'package:todo_app_ornegim/ui/cubit/allcategorypage_cubit.dart';

import '../../data/entity/constants.dart';


class AllCategoriesPage extends StatefulWidget {
  const AllCategoriesPage({super.key});

  @override
  State<AllCategoriesPage> createState() => _AllCategoriesPageState();
}

class _AllCategoriesPageState extends State<AllCategoriesPage> with SingleTickerProviderStateMixin{


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AllCategoryPageCubit>().loadCategories();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title:  Text("All Categories",style: Constants.getTitleTextStyle(18),),
      iconTheme: IconThemeData(
          color: Colors.white,
          size: ScreenUtil().orientation == Orientation.portrait ? 30 : 40
      ),
      backgroundColor: Colors.blue,

    );

  }

  Widget _buildBody() {
    return _buildListView();
  }

  Widget _buildListView() {
    return BlocBuilder<AllCategoryPageCubit,List<CategoryModel>>(builder: (context,categories){
      if(categories.isNotEmpty){
        return GridView.builder(padding: const EdgeInsets.all(15),itemCount: categories.length,gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(mainAxisExtent: ScreenUtil().orientation == Orientation.portrait ? 200 : 300,crossAxisCount: ScreenUtil().orientation == Orientation.portrait ?  2  : 3,crossAxisSpacing: 20,mainAxisSpacing: 25), itemBuilder: (context,index){
          var currentElement = categories[index];
          return _buildListItem(currentElement);
        });
      }
      else{
        return const Center(child: Text("You don't have any categories",style: TextStyle(fontSize: 18),),);
      }
    });
  }

  Widget _buildListItem(CategoryModel currentElement) {
    return GestureDetector(
      onTap: (){
        ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
    backgroundColor: Colors.grey.shade900,
    content: Text("Are you sure you want to delete the category with ${currentElement.categoryID} id?",style: Constants.getFontTextStyle(16),),
  action: SnackBarAction(textColor: Colors.green,label: "Yes", onPressed: (){
    context.read<AllCategoryPageCubit>().deleteCategory(currentElement.categoryID);
    context.read<AllCategoryPageCubit>().loadCategories();

  }),
closeIconColor: Colors.white,
showCloseIcon: true,
),
        );
            
      },
      child: Container(

        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [

            BoxShadow(
              color: Colors.blue,
              blurRadius: 5,

            ),



            BoxShadow(
              color: Colors.blueGrey,
              blurRadius: 5,

            ),


          ],


        ),

        child: Text(currentElement.categoryName,textAlign: TextAlign.center,style: Constants.getTitleTextStyle(15),),
      ),
    );
  }
}
