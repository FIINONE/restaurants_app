class ScheduleModel {
  final int id;
  final String opening;
  final String closing;
  ScheduleModel({
    required this.id,
    required this.opening,
    required this.closing,
  });

  ScheduleModel copyWith({
    int? id,
    String? opening,
    String? closing,
  }) {
    return ScheduleModel(
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

  factory ScheduleModel.fromMap(Map<String, dynamic> map) {
    return ScheduleModel(
      id: map['id']?.toInt(),
      opening: map['opening'],
      closing: map['closing'],
    );
  }
}
