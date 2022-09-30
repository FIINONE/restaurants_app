import 'package:test_restaurants_app/common/utils/validator.dart';

class ImageModel {
  final int id;
  final String url;
  final int restaurantId;
  ImageModel({
    required this.id,
    required this.url,
    required this.restaurantId,
  });

  bool get urlIsLink => ValidatorUtil.instance.isLink(url);

  ImageModel copyWith({
    int? id,
    String? url,
    int? restaurantId,
  }) {
    return ImageModel(
      id: id ?? this.id,
      url: url ?? this.url,
      restaurantId: restaurantId ?? this.restaurantId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'url': url,
      'restaurant_id': restaurantId,
    };
  }

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      id: map['id']?.toInt(),
      url: map['url'],
      restaurantId: map['restaurant_id']?.toInt(),
    );
  }
}
