import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:test_restaurants_app/common/routes/app_routes.dart';
import 'package:test_restaurants_app/controllers/auth/auth_cubit.dart';
import 'package:test_restaurants_app/controllers/errors_cubit.dart';
import 'package:test_restaurants_app/controllers/user_cubit.dart';
import 'package:test_restaurants_app/ui/pages/auth_page/auth_page.dart';
import 'package:test_restaurants_app/ui/pages/home/home.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();

    context.read<AuthCubit>().getUser();
  }

  @override
  void dispose() {
    super.dispose();

    print('dispose');
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppErrorsCubit, String?>(
      listener: (context, errors) {
        if (errors == null) return;
        EasyLoading.showError(
          errors,
          duration: const Duration(seconds: 60),
          dismissOnTap: true,
        );
      },
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is UnAuthenticated) {
            context.read<UserCubit>().disposeUser();
          }
          if (state is Authenticated) {
            context.read<UserCubit>().initUser(state.user);
          }
        },
        builder: (context, state) {
          return state.map(
            loading: (loading) => const Center(
              child: CircularProgressIndicator(),
            ),
            authenticated: (auth) {
              return const HomePage();
            },
            unAuthenticated: (unAuthenticated) {
              return const AuthPage();
            },
          );
        },
      ),
    );
  }
}
