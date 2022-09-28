import 'package:flutter_bloc/flutter_bloc.dart';

class TextCubit extends Cubit<String?> {
  TextCubit({String? initial}) : super(initial);

  void setText(String? text) => emit(text);
  void clear() => emit(null);
}
