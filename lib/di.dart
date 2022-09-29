import 'package:get_it/get_it.dart';
import 'package:test_restaurants_app/common/core/network/http_router.dart';
import 'package:test_restaurants_app/controllers/auth/auth_cubit.dart';
import 'package:test_restaurants_app/controllers/errors_cubit.dart';
import 'package:test_restaurants_app/controllers/restaurants/restaurants_cubit.dart';
import 'package:test_restaurants_app/controllers/user_cubit.dart';
import 'package:test_restaurants_app/data/providers/auth_provider.dart';
import 'package:test_restaurants_app/data/providers/restaurants_provider.dart';
import 'package:test_restaurants_app/data/repository/auth_repo.dart';
import 'package:test_restaurants_app/data/repository/restaurant_repo.dart';

final sl = GetIt.instance;

void setup() {
  sl.registerLazySingleton(() => AppApiRouter.instance);

  /// дата провайдеры
  sl.registerLazySingleton(() => RestaurantsProvider(sl.call()));
  sl.registerLazySingleton(() => AuthProvider(sl.call()));

  ///репозитории
  sl.registerLazySingleton(() => RestaurantsRepo(sl.call()));
  sl.registerLazySingleton(() => AuthRepo(sl.call()));

  /// блоки
  sl.registerLazySingleton(() => AppErrorsCubit());
  sl.registerLazySingleton(() => UserCubit());
  sl.registerLazySingleton(() => RestaurantsCubit(sl.call()));
  sl.registerLazySingleton(() => AuthCubit(sl.call(), sl.call()));
}
