import 'package:either_dart/either.dart';
import 'package:test_restaurants_app/common/core/error/failures.dart';
import 'package:test_restaurants_app/data/models/restaurant_all_model.dart';
import 'package:test_restaurants_app/data/providers/restaurants_provider.dart';

class RestaurantsRepo {
  final RestaurantsProvider provider;

  RestaurantsRepo(this.provider);

  Future<Either<Failure, RestaurantsAllModel>> getRestaurants() {
    return provider.getRestaurants();
  }
}
