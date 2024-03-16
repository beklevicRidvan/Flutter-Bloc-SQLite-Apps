import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:hiveiletodoapp/data/local_storage.dart';
import 'package:hiveiletodoapp/main.dart';
import 'package:hiveiletodoapp/models/task_model.dart';
import 'package:hiveiletodoapp/widgets/custom_search_delegate.dart';
import 'package:hiveiletodoapp/widgets/task_list_item.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late List<Task> _allTask;
  late LocalStorage _localStorage;


  @override
  void initState() {
    // TODO: implement initState
    _localStorage = locator<LocalStorage>();
    _allTask = <Task>[];
    _getAllTaskFromDb();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor:Colors.white,

        title: GestureDetector(onTap: (){
          _showAddTaskBottomSheet();
        },child: Text("title").tr()),
        centerTitle: false,
        actions: [
          IconButton(onPressed: (){
            _showSearchPage();
          }, icon: Icon(Icons.search)),
          IconButton(onPressed: (){
            _showAddTaskBottomSheet();
          }, icon: Icon(Icons.add)),

        ],

      ),

      body:  _allTask.isNotEmpty ? ListView.builder(itemCount: _allTask.length,itemBuilder: (context,index){
        var _oankiGorev = _allTask[index];
        return Dismissible(
          background: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.delete,
                color: Colors.grey,
              ),
              const SizedBox(
                width: 8,
              ),
              Text('remove_task').tr()
            ],
          ),
          key: Key(_oankiGorev.id),
          onDismissed: (direction)async{
            _allTask.removeAt(index);
            _localStorage.deleteTask(task: _oankiGorev);
            setState(() {

            });
          },
          child: TaskListItem(oankiGorev: _oankiGorev),
        );
      }) : Center(child: Text("empty_task_list",style: TextStyle(fontSize: 30),).tr(),)
    );
  }

  void _showAddTaskBottomSheet() {
    showModalBottomSheet(context: context, builder: (context) {
      return  Container(

        padding: EdgeInsets.only(bottom:  MediaQuery.of(context).viewInsets.bottom),
        width: MediaQuery.of(context).size.width,
        child:  ListTile(
          title: TextField(
            autofocus: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "add_task".tr(),
            ),
            onSubmitted: (value){
              Navigator.pop(context);
              if(value.length>3){
                DatePicker.showTimePicker(context,
                    showSecondsColumn: false,
                    onConfirm: (time)async{
                        var yeniEklenecekGorev = Task.create(name: value, createdAt: time);
                        _allTask.insert(0,yeniEklenecekGorev);
                        await _localStorage.addTask(task: yeniEklenecekGorev);
                        setState(() {
                          
                        });
                    });
              }

            },
          ),
        ),
      );
    });
  }

  void _getAllTaskFromDb() async{
    _allTask = await _localStorage.getAllTask();
    setState(() {

    });
  }

  void _showSearchPage() async {
    await showSearch(context: context, delegate: CustomSearchDelegate(allTasks: _allTask));

    _getAllTaskFromDb();
  }
}

