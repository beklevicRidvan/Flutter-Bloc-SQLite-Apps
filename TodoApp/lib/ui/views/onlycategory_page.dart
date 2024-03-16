import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app_ornegim/data/entity/category_model.dart';
import 'package:todo_app_ornegim/ui/cubit/onlycategory_page_cubit.dart';

import '../../data/entity/constants.dart';
import '../../data/entity/todo_model.dart';

class OnlyCategoryPage extends StatefulWidget {
  final CategoryModel currentElement;
  const OnlyCategoryPage({required this.currentElement,super.key});

  @override
  State<OnlyCategoryPage> createState() => _OnlyCategoryPageState();
}

class _OnlyCategoryPageState extends State<OnlyCategoryPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<OnlyCategoryPageCubit>().getTodosByCategoryId(widget.currentElement.categoryID);
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
      iconTheme: IconThemeData(
        size: ScreenUtil().orientation == Orientation.portrait ? 30 : 40,
        color: Colors.white
      ),
      title: Text(widget.currentElement.categoryName,style: Constants.getTitleTextStyle(20),),
      backgroundColor: Colors.blueAccent,
    );
 }

  Widget _buildBody() {
    return BlocBuilder<OnlyCategoryPageCubit,List<TodoModel>>(builder: (context,todos){
      return ListView.builder(itemCount: todos.length,itemBuilder: (context,index){
        var currentTodo = todos[index];
        return _buildListItem(currentTodo);
        
        
      });
    });
  }

  Widget _buildListItem(TodoModel currentTodo) {
    return Card(
      margin: const EdgeInsets.only(top: 15,right: 15,left: 15),
      shadowColor: Colors.white,
      elevation: 5,
      child: ListTile(


        contentPadding: ScreenUtil().orientation == Orientation.portrait  ? const EdgeInsets.symmetric(horizontal: 15)  : const EdgeInsets.all(30),

        title: Text(currentTodo.description,style: Constants.getFontTextStyle(20),),
        subtitle: currentTodo.isCompleted ?  Text("Completed",style: Constants.getSubTitleTextStyle(14),):  Text("Uncompleted",style: Constants.getSubTitleTextStyle(14),),
        trailing: currentTodo.isCompleted ?  Icon(Icons.check, size: ScreenUtil().orientation == Orientation.portrait ? 30 : 40,) :  Icon(Icons.timelapse, size: ScreenUtil().orientation == Orientation.portrait ? 30 : 40),

      ),
    );
  }
}
