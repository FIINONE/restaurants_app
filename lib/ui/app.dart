import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:test_restaurants_app/common/routes/app_routes.dart';
import 'package:test_restaurants_app/common/themes/app_theme.dart';
import 'package:test_restaurants_app/controllers/auth/auth_cubit.dart';
import 'package:test_restaurants_app/controllers/errors_cubit.dart';
import 'package:test_restaurants_app/controllers/favorite_cubit.dart';
import 'package:test_restaurants_app/controllers/restaurant_detail/restaurant_detailed_cubit.dart';
import 'package:test_restaurants_app/controllers/restaurants/restaurants_cubit.dart';
import 'package:test_restaurants_app/controllers/user_cubit.dart';
import 'package:test_restaurants_app/di.dart';
import 'package:test_restaurants_app/ui/pages/loading_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl.get<AuthCubit>()),
        BlocProvider(create: (_) => sl.get<AppErrorsCubit>()),
        BlocProvider(create: (_) => sl.get<UserCubit>()),
        BlocProvider(create: (_) => sl.get<RestaurantsAllCubit>()),
        BlocProvider(create: (_) => sl.get<RestaurantDetailedCubit>()),
        BlocProvider(create: (_) => sl.get<FavoriteCubit>()),
      ],
      child: MaterialApp(
        theme: AppTheme.light,
        onGenerateRoute: AppRoutes.instance.onGenerateRoute,
        home: const LandingPage(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
