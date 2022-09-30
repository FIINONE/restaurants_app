import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_restaurants_app/data/models/restaurant_all_model.dart';
import 'package:test_restaurants_app/data/repository/restaurant_repo.dart';

part 'restaurants_state.dart';

class RestaurantsAllCubit extends Cubit<RestaurantsState> {
  final RestaurantsRepo _repo;

  RestaurantsAllCubit(this._repo) : super(RestaurantsLoading());

  Timer? _bouncing;

  RestaurantsAllModel? _data;

  Future<void> getRestaurants({String? search}) async {
    emit(RestaurantsLoading());

    if (search != null && search.isNotEmpty) {
      _bouncing?.cancel();

      _bouncing = Timer(const Duration(seconds: 2), () async {
        final result = await _repo.getRestaurants(search: search);

        result.fold(
          (failure) => emit(RestaurantsError(message: failure.message)),
          (restaurants) {
            _data = restaurants;
            emit(RestaurantsData(restaurants: restaurants));
          },
        );
      });
    } else {
      _bouncing?.cancel();

      final result = await _repo.getRestaurants();

      result.fold(
        (failure) => emit(RestaurantsError(message: failure.message)),
        (restaurants) {
          _data = restaurants;
          emit(RestaurantsData(restaurants: restaurants));
        },
      );
    }
  }

  void updateState(int restaurantsID) {
    if (_data == null) return;

    final index = _data!.restaurants.indexWhere((element) => element.id == restaurantsID);

    if (!index.isNegative) {
      final rest = _data!.restaurants[index];
      final newRest = rest.copyWith(isFavourite: !rest.isFavourite);
      _data!.restaurants[index] = newRest;

      emit(RestaurantsData(restaurants: _data!));
    }
  }
}
