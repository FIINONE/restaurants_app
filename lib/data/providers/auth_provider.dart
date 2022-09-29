import 'package:either_dart/either.dart';
import 'package:test_restaurants_app/common/core/error/failures.dart';
import 'package:test_restaurants_app/common/core/network/network.dart';
import 'package:test_restaurants_app/common/utils/preference_helper.dart';
import 'package:test_restaurants_app/data/models/auth_model.dart';
import 'package:test_restaurants_app/data/models/token_model.dart';
import 'package:test_restaurants_app/data/models/user_model.dart';

class AuthProvider {
  final AppApiRouter apiRouter;

  AuthProvider(this.apiRouter);

  Future<Either<Failure, UserModel>> getUser(String token) async {
    try {
      final response = await apiRouter.sendRequest(
        request: AppHttpRequest(
          path: AppHttpPath.getProfile,
          method: AppHttpMethod.get,
          token: token,
        ),
      );

      final model = UserModel.fromMap(response.map);

      return Right(model);
    } on AppHttpException catch (e) {
      return AppHttpException.statusCodeFailure(e.statusCode, e.map);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  Future<Either<Failure, AuthModel>> login({
    required String? email,
    required String? nickname,
    required String passwod,
  }) async {
    try {
      final response = await apiRouter.sendRequest(
        request: AppHttpRequest(
          path: AppHttpPath.login,
          method: AppHttpMethod.post,
          token: null,
          body: {
            if (email != null) "email": email,
            if (nickname != null) "nickname": nickname,
            "password": passwod,
          },
        ),
      );

      final model = AuthModel.fromMap(response.map);

      return Right(model);
    } on AppHttpException catch (e) {
      return AppHttpException.statusCodeFailure(e.statusCode, e.map);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  Future<Either<Failure, AuthModel>> registration({
    required String email,
    required String nickname,
    required String passwod,
    required String phone,
  }) async {
    try {
      final response = await apiRouter.sendRequest(
        request: AppHttpRequest(
          path: AppHttpPath.registration,
          method: AppHttpMethod.post,
          token: null,
          body: {
            "email": email,
            "nickname": nickname,
            "phone": phone,
            "password": passwod,
          },
        ),
      );

      final model = AuthModel.fromMap(response.map);

      return Right(model);
    } on AppHttpException catch (e) {
      return AppHttpException.statusCodeFailure(e.statusCode, e.map);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  Future<Either<Failure, TokensModel>> refreshToken(String refreshToken) async {
    try {
      final response = await apiRouter.sendRequest(
        request: AppHttpRequest(
          path: AppHttpPath.refreshToken,
          method: AppHttpMethod.post,
          token: null,
          body: {"refreshToken": refreshToken},
        ),
      );

      final model = TokensModel.fromMap(response.map['tokens']);

      return Right(model);
    } on AppHttpException catch (e) {
      return AppHttpException.statusCodeFailure(e.statusCode, e.map);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
