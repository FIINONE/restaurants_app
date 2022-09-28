import 'package:flutter_bloc/flutter_bloc.dart';

class ToggleCubit extends Cubit<bool> {
  ToggleCubit({bool initial = false}) : super(initial);

  void setValue(bool value) {
    emit(value);
  }

  void setFalse() => emit(false);
  void setTrue() => emit(true);

  void toggle() => emit(!state);

  void setState(bool bool) {
    emit(bool);
  }
}
