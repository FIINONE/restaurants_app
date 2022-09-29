import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_restaurants_app/bloc/restaurants/restaurants_bloc.dart';
import 'package:test_restaurants_app/common/routes/app_routes.dart';
import 'package:test_restaurants_app/common/themes/app_theme.dart';
import 'package:test_restaurants_app/di.dart';
import 'package:test_restaurants_app/ui/pages/auth_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => sl.get<RestaurantsBloc>())],
      child: MaterialApp(
        theme: AppTheme.light,
        onGenerateRoute: AppRoutes.instance.onGenerateRoute,
        home: const AuthPage(),
      ),
    );
  }
}
