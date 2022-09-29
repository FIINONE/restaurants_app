import 'package:flutter/material.dart';
import 'package:test_restaurants_app/common/routes/app_routes.dart';
import 'package:test_restaurants_app/common/themes/app_colors.dart';

import 'package:test_restaurants_app/ui/widgets/app_button.dart';
import 'package:test_restaurants_app/ui/widgets/app_textfield.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    final topPadding = height * 0.28;
    final double bottomPadding = keyboardVisible ? height * 0.2 : 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Авторизация'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: topPadding),
            child: Container(
              decoration: const BoxDecoration(color: AppColors.white_1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  AppTextField(
                    hintText: 'Логин или почта',
                  ),
                  Divider(
                    indent: 16,
                    endIndent: 16,
                  ),
                  AppTextField(hintText: 'Пароль'),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32.0, left: 16, right: 16),
            child: AppButton(
              text: 'Войти',
              onTap: () {},
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 19.0, left: 16, right: 16, bottom: bottomPadding),
            child: AppButton(
              text: 'Зарегистрироваться',
              onTap: () {
                Navigator.pushNamed(context, AppRoutesName.registration);
              },
            ),
          ),
        ],
      ),
    );
  }
}
