import 'package:either_dart/either.dart';
import 'package:test_restaurants_app/data/models/like_model.dart';
import 'package:test_restaurants_app/data/models/restaurant_model.dart';
import 'package:test_restaurants_app/common/core/error/failures.dart';
import 'package:test_restaurants_app/data/providers/favorite_provider.dart';

class FavoriteRepo {
  final FavoriteProvider _favoriteProvider;

  FavoriteRepo(this._favoriteProvider);

  Future<Either<Failure, List<RestaurantModel>>> getFavoriteRestaurants() {
    return _favoriteProvider.getFavoriteRestauramts();
  }

  Future<Either<Failure, LikeModel>> addTOFavorite({required String restaurantID}) {
    return _favoriteProvider.addTOFavorite(restaurantID: restaurantID);
  }

  Future<Either<Failure, bool>> deleteFromFavorite({required String restaurantID}) {
    return _favoriteProvider.deleteFromFavorite(restaurantID: restaurantID);
  }
}
