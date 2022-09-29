import 'package:either_dart/either.dart';
import 'package:test_restaurants_app/common/utils/preference_helper.dart';
import 'package:test_restaurants_app/common/utils/validator.dart';
import 'package:test_restaurants_app/data/models/auth_model.dart';
import 'package:test_restaurants_app/data/models/token_model.dart';
import 'package:test_restaurants_app/data/models/user_model.dart';
import 'package:test_restaurants_app/common/core/error/failures.dart';
import 'package:test_restaurants_app/data/providers/auth_provider.dart';

class AuthRepo {
  final AuthProvider authProvider;

  AuthRepo(this.authProvider);

  Future<Either<Failure, UserModel>> getUser() async {
    final token = await PreferencesHelper.getString('token');

    if (token.isEmpty) {
      return const Left(UserNotAuthFailure('token is empty'));
    }

    return authProvider.getUser(token);
  }

  Future<Either<Failure, AuthModel>> login({
    required String? email,
    required String? nickname,
    required String passwod,
  }) async {
    final result = await authProvider.login(email: email, nickname: nickname, passwod: passwod);

    if (result.isRight) {
      final auth = result.right;

      await _saveToken(auth.tokens);
    }

    return result;
  }

  Future<Either<Failure, AuthModel>> registration({
    required String email,
    required String nickname,
    required String password,
    required String phone,
  }) async {
    final result = await authProvider.registration(email: email, passwod: password, nickname: nickname, phone: phone);

    if (result.isRight) {
      final auth = result.right;
      await _saveToken(auth.tokens);
    }

    return result;
  }

  Future<Either<Failure, TokensModel>> refreshToken() async {
    final refreshToken = await PreferencesHelper.getString('refresh_token');

    final result = await authProvider.refreshToken(refreshToken);

    if (result.isRight) {
      final tokens = result.right;
      await _saveToken(tokens);
    }

    return result;
  }

  Future<bool> logout() async {
    return await PreferencesHelper.clear();
  }

  Future<void> _saveToken(TokensModel tokens) async {
    final token = tokens.accessToken;
    final refreshToken = tokens.refreshToken;
    await PreferencesHelper.setString('token', token);
    await PreferencesHelper.setString('refresh_token', refreshToken);
  }
}
