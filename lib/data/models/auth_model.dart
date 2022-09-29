import 'package:test_restaurants_app/data/models/token_model.dart';
import 'package:test_restaurants_app/data/models/user_model.dart';

class AuthModel {
  final TokensModel tokens;
  final UserModel user;
  AuthModel({
    required this.tokens,
    required this.user,
  });

  AuthModel copyWith({
    TokensModel? tokens,
    UserModel? user,
  }) {
    return AuthModel(
      tokens: tokens ?? this.tokens,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tokens': tokens.toMap(),
      'user': user.toMap(),
    };
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      tokens: TokensModel.fromMap(map['tokens']),
      user: UserModel.fromMap(map['user']),
    );
  }
}
