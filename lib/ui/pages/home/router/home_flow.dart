import 'package:flutter/material.dart';
import 'package:test_restaurants_app/ui/pages/home/router/home_router.dart';
import 'package:test_restaurants_app/ui/pages/home/screens/favorite_screen.dart';
import 'package:test_restaurants_app/ui/pages/home/screens/map_screen.dart';
import 'package:test_restaurants_app/ui/pages/home/screens/profile_screen.dart';
import 'package:test_restaurants_app/ui/pages/home/screens/restaurant_detailed.dart';
import 'package:test_restaurants_app/ui/pages/home/screens/restaurants_list_screen.dart';

class HomeFlow extends StatefulWidget {
  const HomeFlow({Key? key}) : super(key: key);

  @override
  State<HomeFlow> createState() => _HomeFlowState();
}

class _HomeFlowState extends State<HomeFlow> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: HomeRouter.instance.navigatorKey,
      initialRoute: HomeRouter.restaurantsList,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case HomeRouter.restaurantsList:
            return HomeRouter.instance.wrapToRoute(settings, const RestaurantsListScreens());
          case HomeRouter.restaurantDetailed:
            return HomeRouter.instance.wrapToRoute(settings, const RestaurantDetailedPage());
          case HomeRouter.map:
            return HomeRouter.instance.wrapToRoute(settings, const MapScreen());
          case HomeRouter.favorite:
            return HomeRouter.instance.wrapToRoute(settings, const FavoriteScreen());
          case HomeRouter.profile:
            return HomeRouter.instance.wrapToRoute(settings, const ProfileScreen());
          default:
            return HomeRouter.instance.wrapToRoute(settings, const RestaurantsListScreens());
        }
      },
    );
  }
}
