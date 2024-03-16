import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/entity/constants.dart';
import '../../data/entity/todo_model.dart';
import '../cubit/todopage_checkbox_cubit.dart';
import '../cubit/todopage_cubit.dart';
import 'widgets/floatingactionbutton_showDialog.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List<int> completedTaskList = [];

  bool isSelected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<TodoPageCubit>().loadTodos();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoPageCubit, List<TodoModel>>(
      builder: (context, todoList) {
        if (todoList.isNotEmpty) {

          return ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (BuildContext context, int index) {
                var currentElement = todoList[index];
                bool isChecked = completedTaskList.contains(currentElement.id);

                return _buildListItem(index, currentElement, isChecked);
              });



        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.blueAccent,
            ),
          );
        }
      },
    );
    

  }




  Widget _buildListItem(int index, TodoModel currentElement, bool isChecked) {
    return Card(
      margin: const EdgeInsets.only(top: 15,right: 15,left: 15,bottom: 2),
      elevation: 5,
      shadowColor: Colors.blue.shade200,
      color: Colors.grey.shade900,
      child: ListTile(
        contentPadding: Constants.getPadding(),

        title: Text(currentElement.description,style: Constants.getListItemTextStyle(),),
        subtitle: Text(currentElement.isCompleted ? "Completed" : "Uncompleted",style: Constants.getSubTitleTextStyle(17),),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(onPressed: (){
              var alertDialog = FloatingShowDialog(context);


              alertDialog.my2ShowDialog(context, currentElement);
            }, icon: Icon(CupertinoIcons.pen,color: Colors.white,size: ScreenUtil().orientation == Orientation.portrait ? 25 : 50,)),
            IconButton(onPressed: (){
              context.read<TodoPageCubit>().deleteTodo(currentElement.id);
              context.read<TodoPageCubit>().loadTodos();
            }, icon: Icon(CupertinoIcons.xmark,size: ScreenUtil().orientation == Orientation.portrait ? 25 : 50,)),
          ],
        ),
        leading: Transform.scale(
          scale: ScreenUtil().orientation == Orientation.portrait ? 1.3 : 2,
          child: Checkbox(
            activeColor: Colors.blue,
            checkColor: Colors.white,
            value: currentElement.isCompleted,
            onChanged: (bool? checkValue) {
              if (checkValue != null) {

                currentElement.isCompleted = isChecked;

                setState(() {
                  if (checkValue) {
                    completedTaskList.add(currentElement.id);
                    currentElement.isCompleted = true;
                  } else {
                    completedTaskList.remove(currentElement.id);
                    currentElement.isCompleted = false;

                  }
                });


                context.read<TodoPageCheckBoxCubit>().changeCheckBoxState(
                    checkValue);


                context.read<TodoPageCubit>().changeTodoCheckValue(currentElement.id,
                    checkValue,currentElement);



              }
            },
          ),
        ),
        onTap: () {

         
        },

      ),
    );
  }













}