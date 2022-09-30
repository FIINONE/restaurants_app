import 'package:equatable/equatable.dart';

import 'package:test_restaurants_app/data/models/restaurant_model.dart';

abstract class RestaurantDetaildState {}

class RestaurantDetaildLoading extends RestaurantDetaildState {}

class RestaurantDetaildData extends RestaurantDetaildState  {
  final RestaurantModel restaurant;

  RestaurantDetaildData({
    required this.restaurant,
  });
}

class RestaurantDetaildError extends RestaurantDetaildState {
  final String message;

  RestaurantDetaildError({required this.message});
}

extension RestaurantDetaildStateUnion on RestaurantDetaildState {
  T map<T>({
    required T Function(RestaurantDetaildLoading) loading,
    required T Function(RestaurantDetaildData) data,
    required T Function(RestaurantDetaildError) error,
  }) {
    if (this is RestaurantDetaildLoading) return loading(this as RestaurantDetaildLoading);
    if (this is RestaurantDetaildData) return data(this as RestaurantDetaildData);
    if (this is RestaurantDetaildError) return error(this as RestaurantDetaildError);

    throw AssertionError('Union does not match any possible values');
  }
}
