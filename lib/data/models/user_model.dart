class UserModel {
  final int id;
  final String email;
  final String nickname;
  final String phone;
  UserModel({
    required this.id,
    required this.email,
    required this.nickname,
    this.phone = '',
  });

  UserModel copyWith({
    int? id,
    String? email,
    String? nickname,
    String? phone,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      nickname: nickname ?? this.nickname,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'nickname': nickname,
      'phone': phone,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id']?.toInt(),
      email: map['email'],
      nickname: map['nickname'],
      phone: map['phone'] ?? '',
    );
  }
}
