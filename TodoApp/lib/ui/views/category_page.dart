import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app_ornegim/ui/views/onlycategory_page.dart';


import '../../data/entity/category_model.dart';
import '../../data/entity/constants.dart';
import '../cubit/categorypage_completed_cubit.dart';
import '../cubit/categorypage_cubit.dart';
import '../cubit/todopage_cubit.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {




  List<Widget> iconList =const [
    Icon(CupertinoIcons.bag,size: 40,) ,
    Icon(CupertinoIcons.arrow_right_arrow_left),
    Icon(Icons.shopping_basket_outlined,size: 50,),
    Icon(Icons.monitor_heart_outlined,size: 50,),
   Icon(CupertinoIcons.circle_grid_hex_fill,size: 50,),
   Icon(Icons.gamepad_outlined,size: 50,),
   Icon(Icons.directions_walk,size: 50,),
   Icon(Icons.home_work_outlined,size: 50,)

  ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<CategoryPageCubit>().loadwithMy();

  }

  @override
  Widget build(BuildContext context) {


    return BlocBuilder<CategoryPageCubit,List<CategoryModel>>(
      builder: (context,categoryList){
        if(categoryList.isNotEmpty){
          return GridView.builder(gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: ScreenUtil().orientation == Orientation.portrait ? 2 : 3,mainAxisSpacing: 20,crossAxisSpacing: 15,mainAxisExtent: ScreenUtil().orientation == Orientation.portrait ? 200.w : 100.w), padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),itemCount: categoryList.length,itemBuilder: (context,index){
            var currentElement = categoryList[index];
            return _buildListItem(index,currentElement);
          });


        }
        else{
          return const Center(child: CircularProgressIndicator(color: Colors.blueAccent,),);
        }
      },

    );
  }

  Widget _buildListItem(int index,CategoryModel currentElement){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => OnlyCategoryPage(currentElement: currentElement)));
      },
      child: Container(

        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: LinearGradient(colors: [Colors.blue.shade700,Colors.lightBlueAccent],begin: Alignment.topCenter,end: Alignment.bottomCenter)
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [


            Container(

              child: index>=iconList.length ? const Icon(Icons.category,size: 40,) : iconList[index],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children:[
                _buildCompletedTaskCategoryCountWidget(currentElement.categoryID),
                _buildCategoryCountWidget(currentElement.categoryID)
              ],
            ),

            Text(currentElement.categoryName,style:  Constants.getTitleTextStyle(16),),


          ],
        ),
      ),
    );

  }

  Widget _buildCategoryCountWidget(int categoryID) {

    return FutureBuilder<int>(
      future: context.read<TodoPageCubit>().getTaskCountForCategory(categoryID),
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(color: Colors.blueAccent);
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Text("${snapshot.data?.toString()}",style: Constants.getFontTextStyle(17),);
        }
      },
    );






  }

  Widget _buildCompletedTaskCategoryCountWidget(int categoryID) {
    return FutureBuilder<int>(
      future: context.read<CategoryPageCompletedTodoCubit>().loadCategoriesWithCompletedTaskCount(categoryID),
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(color: Colors.blueAccent);
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Text("${snapshot.data?.toString()} / ",style: Constants.getTitleTextStyle(17),);
        }
      },
    );
  }








}






/*
          return GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 20,crossAxisSpacing: 15), padding: EdgeInsets.symmetric(horizontal: 10),itemCount: categoryList.length,itemBuilder: (context,index){
            var currentElement = categoryList[index];
            return _buildListItem(index,currentElement);
          });

           */
/*
          return ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (BuildContext context,int index){
                var currentElement = todoList[index];
                return _buildListItem(currentElement);
              });

           */

