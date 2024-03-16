import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app_ornegim/ui/cubit/home_page_index_cubit.dart';
import 'package:todo_app_ornegim/ui/views/category_page.dart';

import 'package:todo_app_ornegim/ui/views/todo_page.dart';

import '../../data/entity/constants.dart';
import 'allcategoriespage.dart';
import 'completed_todo_page.dart';
import 'widgets/floatingactionbutton_showDialog.dart';
import 'uncompleted_todo_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late List<Widget> bodyPageList;
  late TodoPage todoPage;
  late CategoryPage categoryPage;
  late HomePageIndexCubit homePageIndexCubit;
  double toolbarValue = 200;





  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todoPage = const TodoPage();
    categoryPage = const CategoryPage();
    bodyPageList = [todoPage,categoryPage];
    homePageIndexCubit = context.read<HomePageIndexCubit>();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      resizeToAvoidBottomInset: false,
      drawer: _buildDrawer(),
      appBar: _buildAppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:  _buildFloatingActionButton(),
      bottomNavigationBar: _buildBottomNavigationBar(),
      body:  _buildBody(),

    );
  }

  Drawer _buildDrawer(){
    return Drawer(

      child: Column(
        children: [
          SizedBox(
            height: ScreenUtil().orientation == Orientation.portrait ? 300 : 200,

            child: UserAccountsDrawerHeader(
                accountName:  Text("TODO APP",style: Constants.getTitleTextStyle(25),),
                accountEmail:  Text("rdvn.beklevic@gmail.com",style: Constants.getFontTextStyle(18),),
              decoration: const  BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/appbar_image.jpg"),fit: BoxFit.cover),
                  ),
             currentAccountPicture: ScreenUtil().orientation == Orientation.portrait ? Image.asset("assets/drawer_icon.png") : Container(),
              currentAccountPictureSize:  ScreenUtil().orientation == Orientation.portrait ? Size(250.w, 250.h) : Size(0.3.sw, 0.091.sw),
            ),
          ),
          Expanded(child: ListView(


            children: [

              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const  CompletedTodoPage()));
                },
                child:  ListTile(
                  leading:  Icon(Icons.arrow_forward_ios,size: 20.w),


                  title: Text("Completed Todos",style: Constants.getFontTextStyle(16),),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const UnCompletedTodoPage()));

                },

                child:  ListTile(

                  leading:  Icon(Icons.arrow_forward_ios,size: 20.w),

                  title: Text("Uncompleted Todos",style: Constants.getFontTextStyle(16),),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const AllCategoriesPage()));

                },

                child:  ListTile(

                  leading: Icon(Icons.arrow_forward_ios,size: 20.w,),

                  title: Text("All Categories",style: Constants.getFontTextStyle(16),),
                ),
              )
            ],
          )),



        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leadingWidth: ScreenUtil().orientation == Orientation.portrait ? 60.w : 60.w,
      iconTheme: IconThemeData(

        size: ScreenUtil().orientation == Orientation.portrait ? 50 : 60,
        color: Colors.white
      ),


      flexibleSpace: Container(

        decoration: const BoxDecoration(

          image:  DecorationImage(image: AssetImage("assets/appbar_image.jpg"),fit: BoxFit.cover),
        ),
      ),




      toolbarHeight: ScreenUtil().orientation == Orientation.portrait ? 200 : 70,
      title:  Text("TODO APP",style: Constants.getTitleTextStyle(35),),


    );
  }




  Widget _buildBottomNavigationBar(){
      return BlocBuilder<HomePageIndexCubit,int>(builder: (context,index){
        return BottomNavigationBar(

            currentIndex: index,
            onTap: (selectedIndex){
              context.read<HomePageIndexCubit>().updateSelectedIndex(selectedIndex);
            },
            fixedColor: Colors.white,
            items: [
              BottomNavigationBarItem(
                  tooltip: "Homepage",
                  label: "Homepage",
                  icon: Icon(Icons.home,size: ScreenUtil().orientation == Orientation.portrait ? 35.h:30.w,)
              ),
              BottomNavigationBarItem(
                  tooltip: "Categories",

                  label: "Categories",
                  icon: Icon(Icons.category_outlined,size: ScreenUtil().orientation == Orientation.portrait ? 35.h:30.w,)
              ),

            ]

        );
      });
  }

  Widget _buildFloatingActionButton() {

    var showDialog = FloatingShowDialog(context);
    return BlocBuilder<HomePageIndexCubit, int>(
  builder: (context, index) {
    return SizedBox(
      width: ScreenUtil().orientation == Orientation.portrait ? 70.w : 100.w,
      height: ScreenUtil().orientation == Orientation.portrait ? 80.w : 50.w,
      child: FloatingActionButton(

        onPressed: (){
          if(index == 0){
            showDialog.myShowDialog(context, "CREATE TODO", index);
          }
          else if(index == 1){
            showDialog.myShowDialog(context, "CREATE CATEGORY", index);
          }

        },
      tooltip: "Create Task",
        mini: false,
        splashColor: Colors.black, // İstediğiniz splash rengini ayarlayın
        elevation: 6.0, // Gölge efekti
        highlightElevation: 12.0, // Tıklama anındaki yükseklik efekti

        shape: const CircleBorder(),
        backgroundColor: Colors.blue,
        child:   Icon(Icons.add,size: ScreenUtil().orientation == Orientation.portrait ? 50 : 80,),
      ),
    );
  },
);
  }

 Widget _buildBody() {
    return BlocBuilder<HomePageIndexCubit,int>(builder: (context,currentIndex){
      return currentIndex <= bodyPageList.length -1  ? bodyPageList[currentIndex] : bodyPageList[0];
    });
 }

}
