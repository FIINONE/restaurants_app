import 'package:flutter/material.dart';

class HomeRouter {
  static final instance = HomeRouter._();

  HomeRouter._();

  final navigatorKey = GlobalKey<NavigatorState>();

  static const restaurantsList = '/';
  static const restaurantDetailed = '/restaurant_detailed';
  static const map = '/map';
  static const favorite = '/favorite';
  static const profile = '/profile';

  void goToRestaurantsList() {
    navigatorKey.currentState!.pop();
  }

  Future<void> goToRestaurantDetailed() {
    return _pushNamed(restaurantDetailed);
  }

  Future<void> goToMap() {
    return _pushNamed(map);
  }

  Future<void> goToFavorite() {
    return _pushNamed(favorite);
  }

  Future<void> goToProfile() {
    return _pushNamed(profile);
  }

  Future<void> pop() async {
    return navigatorKey.currentState!.pop();
  }

  Future<void> _pushNamed(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  void _popUntil(String routeName) {
    return navigatorKey.currentState!.popUntil(
      (route) {
        return route.settings.name == routeName;
      },
    );
  }

  Future<void> pushReplacementNamed(String routeName) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName);
  }

  MaterialPageRoute wrapToRoute(RouteSettings settings, Widget page) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => page,
    );
  }
}
