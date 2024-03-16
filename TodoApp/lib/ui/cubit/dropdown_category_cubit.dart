import 'package:flutter_bloc/flutter_bloc.dart';

class DropdownCategoryCubit extends Cubit<int>{
  DropdownCategoryCubit():super(1);

  void changeCategory(int selectedCategory){
    emit(selectedCategory);
  }
}