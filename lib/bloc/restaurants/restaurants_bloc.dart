import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_restaurants_app/bloc/restaurants/restaurants_state.dart';
import 'package:test_restaurants_app/data/repository/restaurant_repo.dart';

class RestaurantsBloc extends Cubit<RestaurantsState> {
  final RestaurantsRepo repo;

  RestaurantsBloc(this.repo) : super(RestaurantsLoading());

  Future<void> getRestaurants() async {
    final result = await repo.getRestaurants();

    result.fold(
      (failure) => emit(RestaurantsError(message: failure.message)),
      (restaurants) => emit(RestaurantsData(restaurants: restaurants)),
    );
  }
}
