import 'package:either_dart/either.dart';
import 'package:test_restaurants_app/common/core/error/failures.dart';
import 'package:test_restaurants_app/common/core/network/network.dart';
import 'package:test_restaurants_app/common/utils/preference_helper.dart';
import 'package:test_restaurants_app/data/models/like_model.dart';
import 'package:test_restaurants_app/data/models/restaurant_model.dart';

class FavoriteProvider {
  final AppApiRouter _apiRouter;

  FavoriteProvider(this._apiRouter);

  Future<Either<Failure, List<RestaurantModel>>> getFavoriteRestauramts() async {
    try {
      final token = await PreferencesHelper.getString('token');

      final result = await _apiRouter.sendRequest(
          request: AppHttpRequest(
        path: AppHttpPath.favorite,
        method: AppHttpMethod.get,
        token: token,
      ));

      final list = result.map['restaurants'] as List;
      final model = List<RestaurantModel>.from(list.map((e) => RestaurantModel.fromMap(e)).toList());

      return Right(model);
    } on AppHttpException catch (e) {
      return AppHttpException.statusCodeFailure(e.statusCode, e.map);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  Future<Either<Failure, LikeModel>> addTOFavorite({required String restaurantID}) async {
    try {
      final token = await PreferencesHelper.getString('token');

      final result = await _apiRouter.sendRequest(
          request: AppHttpRequest(
        path: AppHttpPath.favoriteAdd,
        method: AppHttpMethod.post,
        token: token,
        body: {'restaurant_id': restaurantID},
      ));

      final likeMap = result.map['like'];
      final model = LikeModel.fromMap(likeMap);

      return Right(model);
    } on AppHttpException catch (e) {
      return AppHttpException.statusCodeFailure(e.statusCode, e.map);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  Future<Either<Failure, bool>> deleteFromFavorite({required String restaurantID}) async {
    try {
      final token = await PreferencesHelper.getString('token');

      final response = await _apiRouter.sendRequest(
          request: AppHttpRequest(
        path: AppHttpPath.favoriteDelete,
        method: AppHttpMethod.delete,
        token: token,
        queryPath: restaurantID,
      ));

      return Right(response.map['success']);
    } on AppHttpException catch (e) {
      return AppHttpException.statusCodeFailure(e.statusCode, e.map);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
