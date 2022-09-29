class TokensModel {
  final String accessToken;
  final String refreshToken;
  TokensModel({
    required this.accessToken,
    required this.refreshToken,
  });

  TokensModel copyWith({
    String? accessToken,
    String? refreshToken,
  }) {
    return TokensModel(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  factory TokensModel.fromMap(Map<String, dynamic> map) {
    return TokensModel(
      accessToken: map['accessToken'],
      refreshToken: map['refreshToken'],
    );
  }
}
