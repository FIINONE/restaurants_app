import 'package:flutter/material.dart';
import 'package:test_restaurants_app/common/routes/app_routes.dart';
import 'package:test_restaurants_app/common/themes/app_colors.dart';
import 'package:test_restaurants_app/ui/widgets/app_button.dart';
import 'package:test_restaurants_app/ui/widgets/app_textfield.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Регистрация'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 32.0),
            child: Container(
              color: AppColors.white_1,
              child: Column(
                children: const [
                  AppTextField(hintText: 'Логин'),
                  Divider(),
                  AppTextField(hintText: 'Телефон'),
                  Divider(),
                  AppTextField(hintText: 'Почта'),
                  Divider(),
                  //TODO: 8 character
                  AppTextField(
                    hintText: 'Пароль',
                    isPassword: true,
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 56, top: 32),
            child: AppButton(
              text: 'Создать аккаунт',
              onTap: () {
                Navigator.pushNamed(context, AppRoutesName.home);
              },
            ),
          ),
        ],
      ),
    );
  }
}
