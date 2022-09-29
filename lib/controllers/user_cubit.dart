import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_restaurants_app/data/models/user_model.dart';

class UserCubit extends Cubit<UserModel?> {
  UserCubit() : super(null);

  void initUser(UserModel model) {
    emit(model);
  }

  void disposeUser() {
    emit(null);
  }
}
