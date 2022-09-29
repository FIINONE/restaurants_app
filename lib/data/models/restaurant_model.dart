import 'dart:convert';

class RestaurantModel {
  final bool isFavourite;
  final int id;
  final String title;
  final String description;
  final int scheduleId;
  final int coordsId;
  final int userId;
  final Schedule schedule;
  final Coords coords;
  final List<dynamic> images;
  final User user;
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
    Schedule? schedule,
    Coords? coords,
    List<dynamic>? images,
    User? user,
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
      schedule: Schedule.fromMap(map['schedule']),
      coords: Coords.fromMap(map['coords']),
      images: List<dynamic>.from(map['images']),
      user: User.fromMap(map['user']),
    );
  }
}

class Schedule {
  final int id;
  final String opening;
  final String closing;
  Schedule({
    required this.id,
    required this.opening,
    required this.closing,
  });

  Schedule copyWith({
    int? id,
    String? opening,
    String? closing,
  }) {
    return Schedule(
      id: id ?? this.id,
      opening: opening ?? this.opening,
      closing: closing ?? this.closing,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'opening': opening,
      'closing': closing,
    };
  }

  factory Schedule.fromMap(Map<String, dynamic> map) {
    return Schedule(
      id: map['id']?.toInt(),
      opening: map['opening'],
      closing: map['closing'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Schedule.fromJson(String source) => Schedule.fromMap(json.decode(source));

  @override
  String toString() => 'Schedule(id: $id, opening: $opening, closing: $closing)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Schedule && other.id == id && other.opening == opening && other.closing == closing;
  }

  @override
  int get hashCode => id.hashCode ^ opening.hashCode ^ closing.hashCode;
}

class Coords {
  final int id;
  final double longitude;
  final double latitude;
  final String addressName;
  Coords({
    required this.id,
    required this.longitude,
    required this.latitude,
    required this.addressName,
  });

  Coords copyWith({
    int? id,
    double? longitude,
    double? latitude,
    String? addressName,
  }) {
    return Coords(
      id: id ?? this.id,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      addressName: addressName ?? this.addressName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'longitude': longitude,
      'latitude': latitude,
      'address_name': addressName,
    };
  }

  factory Coords.fromMap(Map<String, dynamic> map) {
    return Coords(
      id: map['id']?.toInt(),
      longitude: map['longitude']?.toDouble(),
      latitude: map['latitude']?.toDouble(),
      addressName: map['address_name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Coords.fromJson(String source) => Coords.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Coords(id: $id, longitude: $longitude, latitude: $latitude, address_name: $addressName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Coords &&
        other.id == id &&
        other.longitude == longitude &&
        other.latitude == latitude &&
        other.addressName == addressName;
  }

  @override
  int get hashCode {
    return id.hashCode ^ longitude.hashCode ^ latitude.hashCode ^ addressName.hashCode;
  }
}

class User {
  final int id;
  final String email;
  final String nickname;
  User({
    required this.id,
    required this.email,
    required this.nickname,
  });

  User copyWith({
    int? id,
    String? email,
    String? nickname,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      nickname: nickname ?? this.nickname,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'nickname': nickname,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']?.toInt(),
      email: map['email'],
      nickname: map['nickname'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() => 'User(id: $id, email: $email, nickname: $nickname)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User && other.id == id && other.email == email && other.nickname == nickname;
  }

  @override
  int get hashCode => id.hashCode ^ email.hashCode ^ nickname.hashCode;
}
