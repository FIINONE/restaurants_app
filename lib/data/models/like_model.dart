class LikeModel {
  final int userId;
  final int restaurantId;
  final int id;
  LikeModel({
    required this.userId,
    required this.restaurantId,
    required this.id,
  });

  LikeModel copyWith({
    int? userId,
    int? restaurantId,
    int? id,
  }) {
    return LikeModel(
      userId: userId ?? this.userId,
      restaurantId: restaurantId ?? this.restaurantId,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'restaurant_id': restaurantId,
      'id': id,
    };
  }

  factory LikeModel.fromMap(Map<String, dynamic> map) {
    return LikeModel(
      userId: map['user_id']?.toInt(),
      restaurantId: map['restaurant_id']?.toInt(),
      id: map['id']?.toInt(),
    );
  }
}
