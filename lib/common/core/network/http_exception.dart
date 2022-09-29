import 'dart:developer';

import 'package:either_dart/either.dart';
import 'package:test_restaurants_app/common/core/error/failures.dart';

class AppHttpException {
  final int statusCode;
  final dynamic map;

  const AppHttpException({
    required this.statusCode,
    required this.map,
  });

  static Left<Failure, T> statusCodeFailure<T>(int statusCode, Map<String, dynamic> map) {
    log(map.toString());
    switch (statusCode) {
      case 401:
        final String message = map['message'];
        return Left(UserNotAuthFailure(message));

      default:
        return Left(ServerFailure(map['message']));
    }
  }
}
