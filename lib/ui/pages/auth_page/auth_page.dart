import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:test_restaurants_app/common/routes/app_routes.dart';
import 'package:test_restaurants_app/common/themes/app_colors.dart';
import 'package:test_restaurants_app/controllers/auth/auth_cubit.dart';
import 'package:test_restaurants_app/ui/pages/auth_page/cubit/auth_error_cubit.dart';
import 'package:test_restaurants_app/ui/widgets/app_button.dart';
import 'package:test_restaurants_app/ui/widgets/app_textfield.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    final topPadding = height * 0.28;
    final double bottomPadding = keyboardVisible ? height * 0.2 : 0;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginErrorCubit()),
        BlocProvider(create: (_) => PasswordErrorCubit()),
      ],
      child: Scaffold(
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
                  children: [
                    LoginField(loginController: loginController),
                    const Divider(
                      indent: 16,
                      endIndent: 16,
                    ),
                    PasswordField(passwordController: passwordController),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32.0, left: 16, right: 16),
              child: LoginButton(
                loginController: loginController,
                passwordController: passwordController,
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
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required this.loginController,
    required this.passwordController,
  }) : super(key: key);
  final TextEditingController loginController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    final loginErrorCubit = context.read<LoginErrorCubit>();
    final passwordErrorCubit = context.read<PasswordErrorCubit>();
    final authCubit = context.read<AuthCubit>();

    return AppButton(
      text: 'Войти',
      onTap: () async {
        loginErrorCubit.clear();
        passwordErrorCubit.clear();

        final loginName = loginController.text;
        final password = passwordController.text;

        if (loginController.text.isEmpty) {
          loginErrorCubit.setText('Поле не может быть пустым');
          return;
        }

        if (passwordController.text.isEmpty) {
          passwordErrorCubit.setText('Поле не может быть пустым');
          return;
        }

        await EasyLoading.show();
        await authCubit.login(loginName: loginName, password: password);
        await EasyLoading.dismiss();
      },
    );
  }
}

class PasswordField extends StatelessWidget {
  const PasswordField({
    Key? key,
    required this.passwordController,
  }) : super(key: key);

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PasswordErrorCubit>();

    return AppTextField(
      controller: passwordController,
      hintText: 'Пароль',
      errorCubit: cubit,
    );
  }
}

class LoginField extends StatelessWidget {
  const LoginField({
    Key? key,
    required this.loginController,
  }) : super(key: key);

  final TextEditingController loginController;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginErrorCubit>();

    return AppTextField(
      controller: loginController,
      hintText: 'Логин или почта',
      errorCubit: cubit,
    );
  }
}
