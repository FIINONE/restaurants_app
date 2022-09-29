import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_restaurants_app/common/constants/assets.dart';
import 'package:test_restaurants_app/common/routes/app_routes.dart';
import 'package:test_restaurants_app/common/themes/app_colors.dart';
import 'package:test_restaurants_app/common/themes/app_text_styles.dart';
import 'package:test_restaurants_app/controllers/auth/auth_cubit.dart';
import 'package:test_restaurants_app/controllers/user_cubit.dart';
import 'package:test_restaurants_app/data/models/user_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserModel?>(
      builder: (context, user) {
        if (user == null) {
          Navigator.pushNamedAndRemoveUntil(context, AppRoutesName.auth, (route) => false);

          return const SizedBox.shrink();
        }

        return Padding(
          padding: const EdgeInsets.only(top: 38.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(Assets.svgUserIcon),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    user.nickname,
                    style: AppTextStyles.semiBold.copyWith(fontSize: 24, height: 1.6),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    user.email,
                    style: AppTextStyles.regular.copyWith(fontSize: 16, height: 1.3, color: AppColors.grey_1),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 27.0),
                  child: InkWell(
                    onTap: () async {
                      final authCubit = context.read<AuthCubit>();

                      await EasyLoading.show();
                      await authCubit.logout();
                      await EasyLoading.dismiss();
                    },
                    child: Ink(
                      width: double.infinity,
                      color: AppColors.white_1,
                      padding: const EdgeInsets.symmetric(horizontal: 29, vertical: 22),
                      child: Text(
                        'Выйти',
                        style: AppTextStyles.regular.copyWith(color: AppColors.red),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
