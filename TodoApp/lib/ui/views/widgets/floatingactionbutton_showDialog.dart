import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app_ornegim/data/entity/todo_model.dart';
import 'package:todo_app_ornegim/ui/cubit/categorypage_dropdown_cubit.dart';
import 'package:todo_app_ornegim/ui/cubit/dropdown_category_pageshow_cubit.dart';
import '../../../data/entity/category_model.dart';
import '../../cubit/dropdown_category_cubit.dart';
import '../../cubit/home_page_cubit.dart';
import '../../cubit/todopage_cubit.dart';

class FloatingShowDialog{



  String _myDescription = "";
  final _formKey = GlobalKey<FormState>();


  FloatingShowDialog(BuildContext context){
    context.read<ShowDropDownCategoryCubit>().loadwithCategory();
  }

  Future<void> myShowDialog(BuildContext context, String title, int selectedIndex) async{
    showDialog(
        context: context,
        builder: (context) {
          return BlocBuilder<ShowDropDownCategoryCubit, List<CategoryModel>>(
            builder: (context, categories) {
              return AlertDialog(

                backgroundColor: Colors.grey.shade900,
                title: Text(title),
                content: selectedIndex == 0
                    ? Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Description is required";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (String? value) {
                          if (value != null) {
                            _myDescription = value;
                          }
                        },
                      ),
                       SizedBox(height: ScreenUtil().orientation == Orientation.portrait ? 20 : 5),
                      const Text(
                        "Categories",
                        style: TextStyle(fontSize: 20),
                      ),
                       SizedBox(height: ScreenUtil().orientation == Orientation.portrait ? 20 : 5),
                      BlocBuilder<DropdownCategoryCubit, int>(

                          builder: (context, selectedCategoryId) {
                            if (categories.isEmpty) {
                              return const CircularProgressIndicator(
                                color: Colors.blueAccent,
                              );
                            } else {
                              return DropdownButton<int>(
                                iconSize: 30,
                                  isExpanded: true,
                                  underline: Container(),
                                  value: selectedCategoryId,
                                  items: categories
                                      .map((category) =>
                                      DropdownMenuItem(
                                          value: category.categoryID,
                                          child: Text(category.categoryName)))
                                      .toList(),
                                  onChanged: (int? value) {
                                    if (value != null) {
                                      context
                                          .read<DropdownCategoryCubit>()
                                          .changeCategory(value);
                                    }
                                  });
                            }
                          })
                    ],
                  ),
                )
                    : Form(
                  key: _formKey,
                  child: TextFormField(
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Description is required";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (String? value) {
                      if (value != null) {
                        _myDescription = value;
                      }
                    },
                  ),
                ),
                actions: [
                  BlocBuilder<DropdownCategoryCubit, int>(
                    builder: (context, selectedCategorID) {
                      return ButtonBar(
                        alignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                shape: const RoundedRectangleBorder()),
                            child: const Text(
                              "Cancel",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: const RoundedRectangleBorder()),
                            child: const Text(
                              "Save",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                if (selectedIndex == 0) {
                                  context
                                      .read<HomePageCubit>()
                                      .createTask(_myDescription,selectedCategorID );
                                  Navigator.pop(context);
                                  context.read<TodoPageCubit>().loadTodos();


                                } else if (selectedIndex == 1) {
                                  context
                                      .read<HomePageCubit>()
                                      .createCategory(_myDescription);
                                  Navigator.pop(context);
                                  context.read<CategoryPageDropdownCubit>().loadCategories();


                                }
                              }
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ],
              );
            },
          );
        });
  }


















  Future<void> my2ShowDialog(BuildContext context,TodoModel currentElement) async{
    showDialog(
        context: context,
        builder: (context) {
          return BlocBuilder<ShowDropDownCategoryCubit, List<CategoryModel>>(
            builder: (context, categories) {
              return AlertDialog(
                backgroundColor: Colors.grey.shade900,
                title: const Text("UPDATE TODO"),
                content:  Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        initialValue: currentElement.description,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Description is required";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (String? value) {
                          if (value != null) {
                            _myDescription = value;
                          }
                        },
                      ),
                       SizedBox(height: ScreenUtil().orientation == Orientation.portrait ? 20 : 5),
                      const Text(
                        "Categories",
                        style: TextStyle(fontSize: 20),
                      ),
                       SizedBox(height:  ScreenUtil().orientation == Orientation.portrait ? 20 : 5),
                      BlocBuilder<DropdownCategoryCubit, int>(

                          builder: (context, selectedCategoryId) {
                            if (categories.isEmpty) {
                              return const CircularProgressIndicator(
                                color: Colors.blueAccent,
                              );
                            }
                            else {

                              return DropdownButton<int>(
                                iconSize: 30,
                                  isExpanded: true,
                                  underline: Container(),
                                  value: selectedCategoryId,
                                  items: categories
                                      .map((category) =>
                                      DropdownMenuItem(
                                          value: category.categoryID,
                                          child: Text(category.categoryName)))
                                      .toList(),
                                  onChanged: (int? value) {
                                    if (value != null) {
                                      context
                                          .read<DropdownCategoryCubit>()
                                          .changeCategory(value);
                                    }
                                  });
                            }
                          })
                    ],
                  ),
                ),

                actions: [
                  BlocBuilder<DropdownCategoryCubit, int>(
                    builder: (context, selectedCategorID) {
                      return ButtonBar(
                        alignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                shape: const RoundedRectangleBorder()),
                            child: const Text(
                              "Cancel",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                shape: const RoundedRectangleBorder()),
                            child: const Text(
                              "Update",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                context.read<TodoPageCubit>().updateTodo(currentElement.id, _myDescription, selectedCategorID);
                                Navigator.pop(context);
                                context.read<TodoPageCubit>().loadTodos();
                              }
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ],
              );
            },
          );
        });
  }







}