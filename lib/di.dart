import 'package:get_it/get_it.dart';
import 'package:test_restaurants_app/bloc/restaurants/restaurants_bloc.dart';
import 'package:test_restaurants_app/common/core/network/http_router.dart';
import 'package:test_restaurants_app/data/providers/restaurants_provider.dart';
import 'package:test_restaurants_app/data/repository/restaurant_repo.dart';

final sl = GetIt.instance;

void setup() {
  sl.registerLazySingleton(() => AppApiRouter.instance);

  ///репозитории
  sl.registerLazySingleton(() => RestaurantsRepo(sl.call()));

  /// дата провайдеры
  sl.registerLazySingleton(() => RestaurantsProvider(sl.call()));

  /// блоки
  sl.registerLazySingleton(() => RestaurantsBloc(sl.call()));
}
