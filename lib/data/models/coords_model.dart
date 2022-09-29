class CoordsModel {
  final int id;
  final double longitude;
  final double latitude;
  final String addressName;
  CoordsModel({
    required this.id,
    required this.longitude,
    required this.latitude,
    required this.addressName,
  });

  CoordsModel copyWith({
    int? id,
    double? longitude,
    double? latitude,
    String? addressName,
  }) {
    return CoordsModel(
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

  factory CoordsModel.fromMap(Map<String, dynamic> map) {
    return CoordsModel(
      id: map['id']?.toInt(),
      longitude: map['longitude']?.toDouble(),
      latitude: map['latitude']?.toDouble(),
      addressName: map['address_name'],
    );
  }
}
