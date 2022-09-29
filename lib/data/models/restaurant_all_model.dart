import 'package:test_restaurants_app/data/models/restaurant_model.dart';

class RestaurantsAllModel {
  final int count;
  final List<RestaurantModel> restaurants;

  RestaurantsAllModel({
    required this.count,
    required this.restaurants,
  });

  Map<String, dynamic> toMap() {
    return {
      'count': count,
      'restaurantList': restaurants.map((x) => x.toMap()).toList(),
    };
  }

  factory RestaurantsAllModel.fromMap(Map<String, dynamic> map) {
    return RestaurantsAllModel(
      count: map['count'],
      restaurants: List<RestaurantModel>.from(map['restaurants'].map((x) => RestaurantModel.fromMap(x))),
    );
  }

  RestaurantsAllModel copyWith({
    int? count,
    List<RestaurantModel>? restaurants,
  }) {
    return RestaurantsAllModel(
      count: count ?? this.count,
      restaurants: restaurants ?? this.restaurants,
    );
  }
}
