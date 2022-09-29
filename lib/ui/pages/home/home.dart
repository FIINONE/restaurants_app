import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:test_restaurants_app/common/constants/assets.dart';
import 'package:test_restaurants_app/common/themes/app_colors.dart';
import 'package:test_restaurants_app/ui/pages/home/router/home_router.dart';
import 'package:test_restaurants_app/ui/pages/home/screens/favorite_screen.dart';
import 'package:test_restaurants_app/ui/pages/home/screens/map_screen.dart';
import 'package:test_restaurants_app/ui/pages/home/screens/profile_screen.dart';
import 'package:test_restaurants_app/ui/pages/home/screens/restaurants_list_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  String currentIcon = Assets.svgEat;
  final List<Widget> currentScreen = const [
    RestaurantsListScreens(),
    MapScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];

  static const botNavBarItemList = [
    BotNavBarItemModel(icon: Assets.svgEat, label: 'Лента'),
    BotNavBarItemModel(icon: Assets.svgMap, label: 'Карта'),
    BotNavBarItemModel(icon: Assets.svgLikeOff, label: 'Избранные'),
    BotNavBarItemModel(icon: Assets.svgProfile, label: 'Профиль'),
  ];

  void _onTap(int index) {
    // _bottomNavigate(index);
    setState(() {
      currentIndex = index;
      currentIcon = botNavBarItemList[index].icon;
    });
  }

  void _bottomNavigate(int index) {
    switch (index) {
      case 0:
        HomeRouter.instance.pushReplacementNamed(HomeRouter.restaurantsList);
        break;
      case 1:
        HomeRouter.instance.pushReplacementNamed(HomeRouter.map);
        break;
      case 2:
        HomeRouter.instance.pushReplacementNamed(HomeRouter.favorite);
        break;
      case 3:
        HomeRouter.instance.pushReplacementNamed(HomeRouter.profile);
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _BuildAppBar(title: botNavBarItemList[currentIndex].label),
      body: currentScreen[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: _onTap,
        items: botNavBarItemList
            .map((item) => BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  item.icon,
                  color: currentIcon == item.icon ? AppColors.blue : Colors.black,
                ),
                label: item.label))
            .toList(),
      ),
    );
  }
}

class _BuildAppBar extends StatelessWidget with PreferredSizeWidget {
  const _BuildAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  bool _showAppBar(String title) {
    return title == 'Избранные' || title == 'Профиль';
  }

  @override
  Widget build(BuildContext context) {
    return _showAppBar(title) ? AppBar(title: Text(title)) : const SizedBox.shrink();
  }

  @override
  Size get preferredSize => _showAppBar(title) ? const Size.fromHeight(kToolbarHeight) : Size.zero;
}

class BotNavBarItemModel {
  final String icon;
  final String label;

  const BotNavBarItemModel({
    required this.icon,
    required this.label,
  });
}
