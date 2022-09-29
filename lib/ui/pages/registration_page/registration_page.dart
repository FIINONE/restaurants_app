import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:test_restaurants_app/common/themes/app_colors.dart';
import 'package:test_restaurants_app/controllers/auth/auth_cubit.dart';
import 'package:test_restaurants_app/ui/pages/registration_page/cubit/registration_error_cubit.dart';
import 'package:test_restaurants_app/ui/widgets/app_button.dart';
import 'package:test_restaurants_app/ui/widgets/app_textfield.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final emailController = TextEditingController();
  final nicknameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => EmailErrorCubit()),
        BlocProvider(create: (_) => NicknameErrorCubit()),
        BlocProvider(create: (_) => PhoneErrorCubit()),
        BlocProvider(create: (_) => PasswordErrorCubit()),
      ],
      child: Scaffold(
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
                  children: [
                    _NicknameFiled(nicknameController: nicknameController),
                    const Divider(),
                    _PhoneField(phoneController: phoneController),
                    const Divider(),
                    _EmailField(emailController: emailController),
                    const Divider(),
                    _PasswordField(passwordController: passwordController),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 56, top: 32),
              child: _CreateAccButton(
                  emailController: emailController,
                  passwordController: passwordController,
                  phoneController: phoneController,
                  nicknameController: nicknameController),
            ),
          ],
        ),
      ),
    );
  }
}

class _CreateAccButton extends StatelessWidget {
  const _CreateAccButton({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.phoneController,
    required this.nicknameController,
  }) : super(key: key);

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController phoneController;
  final TextEditingController nicknameController;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      text: 'Создать аккаунт',
      onTap: () async {
        final authCubit = context.read<AuthCubit>();
        final emailErrorCubit = context.read<EmailErrorCubit>();
        final nickErrorCubit = context.read<NicknameErrorCubit>();
        final passwordErrorCubit = context.read<PasswordErrorCubit>();
        final phoneErrorCubit = context.read<PhoneErrorCubit>();

        emailErrorCubit.clear();
        nickErrorCubit.clear();
        passwordErrorCubit.clear();
        phoneErrorCubit.clear();

        final email = emailController.text;
        final password = passwordController.text;
        final phone = phoneController.text;
        final nickname = nicknameController.text;

        if (email.isEmpty) {
          emailErrorCubit.setText('Это поле не может быть пустым');
          return;
        }

        if (nickname.isEmpty) {
          nickErrorCubit.setText('Это поле не может быть пустым');
          return;
        }

        if (password.length < 8) {
          passwordErrorCubit.setText('Минимальная длина пароля составляет 8 символов');
          return;
        }

        if (phone.length < 11) {
          phoneErrorCubit.setText('Минимальная длина номера телефона составляет 11 символов');
          return;
        }

        await EasyLoading.show();
        final result = await authCubit.registration(email: email, password: password, phone: phone, nickname: nickname);
        result.fold((left) => null, (right) => Navigator.pop(context));
        await EasyLoading.dismiss();
      },
    );
  }
}

class _NicknameFiled extends StatelessWidget {
  const _NicknameFiled({
    Key? key,
    required this.nicknameController,
  }) : super(key: key);

  final TextEditingController nicknameController;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NicknameErrorCubit>();

    return AppTextField(
      controller: nicknameController,
      hintText: 'Логин',
      errorCubit: cubit,
    );
  }
}

class _PhoneField extends StatelessWidget {
  const _PhoneField({
    Key? key,
    required this.phoneController,
  }) : super(key: key);

  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PhoneErrorCubit>();

    return AppTextField(
      hintText: 'Телефон',
      controller: phoneController,
      errorCubit: cubit,
    );
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField({
    Key? key,
    required this.emailController,
  }) : super(key: key);

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EmailErrorCubit>();

    return AppTextField(
      hintText: 'Почта',
      controller: emailController,
      errorCubit: cubit,
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({
    Key? key,
    required this.passwordController,
  }) : super(key: key);

  final TextEditingController passwordController;

  //TODO: 8 character
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PasswordErrorCubit>();

    return AppTextField(
      hintText: 'Пароль',
      isPassword: true,
      controller: passwordController,
      errorCubit: cubit,
    );
  }
}
