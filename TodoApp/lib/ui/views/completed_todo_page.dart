import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/entity/constants.dart';
import '../../data/entity/todo_model.dart';
import '../cubit/completedtodopage_cubit.dart';

class CompletedTodoPage extends StatefulWidget {
  const CompletedTodoPage({super.key});

  @override
  State<CompletedTodoPage> createState() => _CompletedTodoPageState();
}

class _CompletedTodoPageState extends State<CompletedTodoPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CompletedTodoPageCubit>().loadCompletedAllTodos();
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
      title:  Text("All Completed Todos",style: Constants.getTitleTextStyle(20),),
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
    return BlocBuilder<CompletedTodoPageCubit,List<TodoModel>>(builder: (context,todos){
      if(todos.isNotEmpty){
        return ListView.builder(itemCount: todos.length,itemBuilder: (context,index){
          var currentElement = todos[index];
          return _buildListItem(currentElement);

        });
      }
      else{
        return const Center(child: Text("You don't have a completed task yet",style: TextStyle(fontSize: 18),),);
      }
    });
  }

  Widget _buildListItem(TodoModel currentElement) {
    return Card(
      margin: const EdgeInsets.only(top: 15,right: 15,left: 15),
      shadowColor: Colors.white,
      elevation: 5,
      
      child: ListTile(
        contentPadding: ScreenUtil().orientation == Orientation.portrait  ? const EdgeInsets.symmetric(horizontal: 15)  : const EdgeInsets.all(15),
        title: Text(currentElement.description,style: Constants.getFontTextStyle(18),),
        trailing:  Icon(Icons.check , size: ScreenUtil().orientation == Orientation.portrait ? 30 : 40,),
      ),
    );
  }
}
