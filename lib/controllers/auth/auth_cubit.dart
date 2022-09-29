import 'package:either_dart/src/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_restaurants_app/common/core/error/failures.dart';
import 'package:test_restaurants_app/common/utils/validator.dart';
import 'package:test_restaurants_app/controllers/errors_cubit.dart';
import 'package:test_restaurants_app/data/models/auth_model.dart';
import 'package:test_restaurants_app/data/models/user_model.dart';
import 'package:test_restaurants_app/data/repository/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _authRepo;
  final AppErrorsCubit _appErrorsCubit;

  AuthCubit(this._authRepo, this._appErrorsCubit) : super(AuthLoading());

  Future<void> getUser() async {
    final result = await _authRepo.getUser();

    result.fold(
      (failure) {
        if (failure is UserNotAuthFailure) {
          emit(UnAuthenticated());
          return;
        }

        _appErrorsCubit.setText(failure.message);
      },
      (user) {
        emit(Authenticated(user));
      },
    );
  }

  Future<void> login({required String loginName, required String password}) async {
    String? email;
    String? nickname;

    final isEmail = ValidatorUtil.instance.isEmail(loginName);
    if (isEmail) {
      email = email;
    } else {
      nickname = loginName;
    }

    final result = await _authRepo.login(email: email, nickname: nickname, passwod: password);

    result.fold(
      (failure) {
        if (failure is UserNotAuthFailure) {
          emit(UnAuthenticated());
          return;
        }

        _appErrorsCubit.setText(failure.message);
      },
      (auth) {
        emit(Authenticated(auth.user));
      },
    );
  }

  Future<Either<Failure, AuthModel>> registration({
    required String email,
    required String password,
    required String phone,
    required String nickname,
  }) async {
    final result = await _authRepo.registration(email: email, password: password, phone: phone, nickname: nickname);

    result.fold(
      (failure) {
        if (failure is UserNotAuthFailure) {
          emit(UnAuthenticated());
          return;
        }

        _appErrorsCubit.setText(failure.message);
      },
      (auth) {
        emit(Authenticated(auth.user));
      },
    );

    return result;
  }

  Future<void> refreshToken() async {
    final result = await _authRepo.refreshToken();

    result.fold(
      (failure) {
        if (failure is UserNotAuthFailure) {
          emit(UnAuthenticated());
          return;
        }

        _appErrorsCubit.setText(failure.message);
      },
      (auth) {},
    );
  }

  Future<bool> logout() async {
    final result = await _authRepo.logout();

    if (result) {
      emit(UnAuthenticated());
    }

    return result;
  }

  void _isEmail(String emailOrNickname) {}
}
