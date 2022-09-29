part of 'restaurants_cubit.dart';

abstract class RestaurantsState {}

class RestaurantsLoading extends RestaurantsState {}

class RestaurantsData extends RestaurantsState {
  final RestaurantsAllModel restaurants;

  RestaurantsData({
    required this.restaurants,
  });
}

class RestaurantsError extends RestaurantsState {
  final String message;

  RestaurantsError({required this.message});
}

extension RestaurantsStateUnion on RestaurantsState {
  T map<T>({
    required T Function(RestaurantsLoading) loading,
    required T Function(RestaurantsData) data,
    required T Function(RestaurantsError) error,
  }) {
    if (this is RestaurantsLoading) return loading(this as RestaurantsLoading);
    if (this is RestaurantsData) return data(this as RestaurantsData);
    if (this is RestaurantsError) return error(this as RestaurantsError);

    throw AssertionError('Union does not match any possible values');
  }
}
