import 'package:flutter_bloc/flutter_bloc.dart';


class TodoPageCheckBoxCubit extends Cubit<bool> {
  TodoPageCheckBoxCubit() : super(false);

  void changeCheckBoxState(bool checkedValues) {
    emit(checkedValues);

  }
}
