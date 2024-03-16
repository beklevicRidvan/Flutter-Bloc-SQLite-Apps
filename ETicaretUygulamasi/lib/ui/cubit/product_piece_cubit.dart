import 'package:flutter_bloc/flutter_bloc.dart';

class ProductPieceCubit extends Cubit<int>{
  ProductPieceCubit():super(1);

  Future<void> increase(int value) async{
    emit(++value);
  }

  Future<void> reduce(int value) async{
    if(value > 0){
      emit(--value);
    }
  }
}