import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_restaurants_app/controllers/restaurant_detail/restaurant_detail_state.dart';
import 'package:test_restaurants_app/data/models/restaurant_model.dart';
import 'package:test_restaurants_app/data/repository/restaurant_repo.dart';

class RestaurantDetailedCubit extends Cubit<RestaurantDetaildState> {
  final RestaurantsRepo _repo;

  RestaurantDetailedCubit(this._repo) : super(RestaurantDetaildLoading());

  RestaurantModel? data;

  Future<void> getRestaurantDetailed(int restaurantID) async {
    emit(RestaurantDetaildLoading());

    final result = await _repo.getRestaurantDetailed(restaurantID);

    result.fold(
      (left) {
        emit(RestaurantDetaildError(message: left.message));
      },
      (restaurant) {
        data = restaurant;
        emit(RestaurantDetaildData(restaurant: restaurant));
      },
    );
  }

  void updateState() {
    if (data == null) return;

    final newData = data!.copyWith(isFavourite: !data!.isFavourite);
    data = newData;

    emit(RestaurantDetaildData(restaurant: newData));
  }
}
