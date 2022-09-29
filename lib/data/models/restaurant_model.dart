import 'package:test_restaurants_app/data/models/coords_model.dart';
import 'package:test_restaurants_app/data/models/schedule_model.dart';
import 'package:test_restaurants_app/data/models/user_model.dart';

class RestaurantModel {
  final bool isFavourite;
  final int id;
  final String title;
  final String description;
  final int scheduleId;
  final int coordsId;
  final int userId;
  final ScheduleModel schedule;
  final CoordsModel coords;
  final List<dynamic> images;
  final UserModel user;
  RestaurantModel({
    required this.isFavourite,
    required this.id,
    required this.title,
    required this.description,
    required this.scheduleId,
    required this.coordsId,
    required this.userId,
    required this.schedule,
    required this.coords,
    required this.images,
    required this.user,
  });

  RestaurantModel copyWith({
    bool? isFavourite,
    int? id,
    String? title,
    String? description,
    int? scheduleId,
    int? coordsId,
    int? userId,
    ScheduleModel? schedule,
    CoordsModel? coords,
    List<dynamic>? images,
    UserModel? user,
  }) {
    return RestaurantModel(
      isFavourite: isFavourite ?? this.isFavourite,
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      scheduleId: scheduleId ?? this.scheduleId,
      coordsId: coordsId ?? this.coordsId,
      userId: userId ?? this.userId,
      schedule: schedule ?? this.schedule,
      coords: coords ?? this.coords,
      images: images ?? this.images,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'is_favourite': isFavourite,
      'id': id,
      'title': title,
      'description': description,
      'schedule_id': scheduleId,
      'coords_id': coordsId,
      'user_id': userId,
      'schedule': schedule.toMap(),
      'coords': coords.toMap(),
      'images': images,
      'user': user.toMap(),
    };
  }

  factory RestaurantModel.fromMap(Map<String, dynamic> map) {
    return RestaurantModel(
      isFavourite: map['is_favourite'],
      id: map['id']?.toInt(),
      title: map['title'],
      description: map['description'],
      scheduleId: map['schedule_id']?.toInt(),
      coordsId: map['coords_id']?.toInt(),
      userId: map['user_id']?.toInt(),
      schedule: ScheduleModel.fromMap(map['schedule']),
      coords: CoordsModel.fromMap(map['coords']),
      images: List<dynamic>.from(map['images']),
      user: UserModel.fromMap(map['user']),
    );
  }
}
