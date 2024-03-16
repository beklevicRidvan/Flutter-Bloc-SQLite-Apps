import 'package:flutter_bloc/flutter_bloc.dart';



class HomePageIndexCubit extends Cubit<int> {
  HomePageIndexCubit() : super(0);



  void updateSelectedIndex(int selectedIndex) {
    emit(selectedIndex);

  }

}
