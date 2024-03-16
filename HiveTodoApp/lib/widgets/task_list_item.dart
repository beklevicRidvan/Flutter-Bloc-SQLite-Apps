import 'package:flutter/material.dart';
import 'package:hiveiletodoapp/data/local_storage.dart';
import 'package:hiveiletodoapp/main.dart';
import 'package:hiveiletodoapp/models/task_model.dart';

class TaskListItem extends StatefulWidget {
  const TaskListItem({
    super.key,
    required Task oankiGorev,
  }) : _oankiGorev = oankiGorev;

  final Task _oankiGorev;

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {

  TextEditingController taskNameController = TextEditingController();
  late LocalStorage _localStorage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _localStorage = locator<LocalStorage>();
  }

  @override
  Widget build(BuildContext context) {
    taskNameController.text = widget._oankiGorev.isim;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.2),blurRadius: 10),
        ]
      ),
      child: ListTile(
        leading: GestureDetector(
            onTap: (){
          widget._oankiGorev.isCompleted = !widget._oankiGorev.isCompleted;
          _localStorage.updateTask(task: widget._oankiGorev);
          setState(() {

          });
        },
          child: Container(
            child:  Icon(Icons.check,color: Colors.white,),
            decoration:  BoxDecoration(
              color: widget._oankiGorev.isCompleted ? Colors.green : Colors.white,
              border: Border.all(color: Colors.grey,width: 0.8),
              shape: BoxShape.circle,
            ),
          )

          ),
        trailing: Text(Task.timeFormat(widget._oankiGorev.createdAt),style: TextStyle(fontSize: 16,color: Colors.grey),),
        title: widget._oankiGorev.isCompleted ?  Text(widget._oankiGorev.isim,style: TextStyle(decoration: TextDecoration.lineThrough,color: Colors.grey ),) :
        TextField(
          controller: taskNameController,
          minLines: 1,
          maxLines: null,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(border: InputBorder.none),
          onSubmitted: (value){
            if(value.length>3){
              widget._oankiGorev.isim = value;
              _localStorage.updateTask(task: widget._oankiGorev);

            }
            setState(() {

            });
          },
        ),
      ),
    );
  }
}
