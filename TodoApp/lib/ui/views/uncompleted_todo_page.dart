import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app_ornegim/ui/cubit/uncompletedpage_cubit.dart';

import '../../data/entity/constants.dart';
import '../../data/entity/todo_model.dart';

class UnCompletedTodoPage extends StatefulWidget {
  const UnCompletedTodoPage({super.key});

  @override
  State<UnCompletedTodoPage> createState() => _UnCompletedTodoPageState();
}

class _UnCompletedTodoPageState extends State<UnCompletedTodoPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<UnCompletedPageCubit>().loadUnCompletedTodos();
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
      title:   Text("All UnCompleted Todos",style: Constants.getTitleTextStyle(18),),
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
    return BlocBuilder<UnCompletedPageCubit,List<TodoModel>>(builder: (context,todos){
      if(todos.isNotEmpty){
        return ListView.builder(itemCount: todos.length,itemBuilder: (context,index){
          var currentElement = todos[index];
          return _buildListItem(currentElement);

        });
      }
      else{
        return const Center(child: Text("You have completed all the tasks",style: TextStyle(fontSize: 18),),);
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
        trailing:  Icon(Icons.timelapse, size: ScreenUtil().orientation == Orientation.portrait ? 30 : 40,),
      ),
    );
  }
}
