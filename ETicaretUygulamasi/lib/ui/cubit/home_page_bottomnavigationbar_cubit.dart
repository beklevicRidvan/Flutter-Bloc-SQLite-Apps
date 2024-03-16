import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageBottomNavigationBarCubit extends Cubit<int>{
  HomePageBottomNavigationBarCubit():super(0);

  Future<void> changeCurrentIndex(int index) async{
    emit(index);
  }
}