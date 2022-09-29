import 'package:flutter/material.dart';
import 'package:test_restaurants_app/ui/pages/auth_page/auth_page.dart';
import 'package:test_restaurants_app/ui/pages/home/home.dart';
import 'package:test_restaurants_app/ui/pages/registration_page/registration_page.dart';

class AppRoutes {
  static final instance = AppRoutes._();
  AppRoutes._();

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesName.auth:
        return MaterialPageRoute(builder: (context) => const AuthPage());

      case AppRoutesName.registration:
        return MaterialPageRoute(builder: (context) => const RegistrationPage());

      case AppRoutesName.home:
        return MaterialPageRoute(builder: (context) => const HomePage());

      default:
        return null;
    }
  }
}

class AppRoutesName {
  static const auth = '/';
  static const registration = '/registration';
  static const home = '/home';
}
