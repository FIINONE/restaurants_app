import 'package:flutter/material.dart';
import 'package:test_restaurants_app/themes/app_theme.dart';
import 'package:test_restaurants_app/ui/pages/auth_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light,
      home: const AuthPage(),
    );
  }
}
