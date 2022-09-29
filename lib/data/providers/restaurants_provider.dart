import 'dart:developer';

import 'package:either_dart/either.dart';
import 'package:test_restaurants_app/common/core/error/failures.dart';
import 'package:test_restaurants_app/common/core/network/network.dart';
import 'package:test_restaurants_app/common/utils/preference_helper.dart';
import 'package:test_restaurants_app/data/models/restaurant_all_model.dart';

class RestaurantsProvider {
  final AppApiRouter apiRouter;

  RestaurantsProvider(this.apiRouter);

  Future<Either<Failure, RestaurantsAllModel>> getRestaurants() async {
    try {
      final token = await PreferencesHelper.getString('token');

      final response = await apiRouter.sendRequest(
          request: AppHttpRequest(path: AppHttpPath.restaurantsAll, method: AppHttpMethod.get, token: token));

      final model = RestaurantsAllModel.fromMap(response.map);
      return Right(model);
    } on AppHttpException catch (e) {
      return AppHttpException.statusCodeFailure(e.statusCode, e.map);
    } catch (e) {
      log('╔════Provider: Error═══───');
      log('║ function getRestaurants');
      log('║ method ${AppHttpMethod.get}');
      log('║ path ${AppHttpPath.restaurantsAll}');
      log('╠════════Error════════───');
      log('║ $e');
      log('╚═══════════════════════───');
      return Left(UnknownFailure(e.toString()));
    }
  }
}
