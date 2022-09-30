import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_restaurants_app/common/core/error/failures.dart';
import 'package:test_restaurants_app/controllers/errors_cubit.dart';
import 'package:test_restaurants_app/data/models/like_model.dart';
import 'package:test_restaurants_app/data/models/restaurant_model.dart';
import 'package:test_restaurants_app/data/repository/favorite_repo.dart';

class FavoriteCubit extends Cubit<List<RestaurantModel>?> {
  final FavoriteRepo _favoriteRepo;
  final AppErrorsCubit _appErrorsCubit;

  FavoriteCubit(this._favoriteRepo, this._appErrorsCubit) : super(null);

  Future<void> getFavoriteRestaurants() async {
    emit(null);

    final result = await _favoriteRepo.getFavoriteRestaurants();

    result.fold(
      (failure) {
        _appErrorsCubit.setText(failure.message);
      },
      (restaurants) {
        emit(restaurants);
      },
    );
  }

  Future<bool> updateFavorite({required bool isFavorite, required int restaurantID}) async {
    bool result = false;

    if (isFavorite) {
      final delete = await _deleteFromFavorite(restaurantID: restaurantID.toString());
      delete.fold((left) => null, (right) => result = right);
    } else {
      final add = await _addTOFavorite(restaurantID: restaurantID.toString());
      add.fold((left) => null, (right) => result = true);
    }

    await getFavoriteRestaurants();

    return result;
  }

  Future<Either<Failure, LikeModel>> _addTOFavorite({required String restaurantID}) async {
    final result = await _favoriteRepo.addTOFavorite(restaurantID: restaurantID);

    result.fold(
      (failure) {
        _appErrorsCubit.setText(failure.message);
      },
      (restaurants) {},
    );

    return result;
  }

  Future<Either<Failure, bool>> _deleteFromFavorite({required String restaurantID}) async {
    final result = await _favoriteRepo.deleteFromFavorite(restaurantID: restaurantID);

    result.fold(
      (failure) {
        _appErrorsCubit.setText(failure.message);
      },
      (restaurants) {},
    );

    return result;
  }
}
