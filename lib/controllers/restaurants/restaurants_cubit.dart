import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_restaurants_app/data/models/restaurant_all_model.dart';
import 'package:test_restaurants_app/data/repository/restaurant_repo.dart';

part 'restaurants_state.dart';

class RestaurantsCubit extends Cubit<RestaurantsState> {
  final RestaurantsRepo _repo;

  RestaurantsCubit(this._repo) : super(RestaurantsLoading());

  Future<void> getRestaurants() async {
    final result = await _repo.getRestaurants();

    result.fold(
      (failure) => emit(RestaurantsError(message: failure.message)),
      (restaurants) => emit(RestaurantsData(restaurants: restaurants)),
    );
  }
}
