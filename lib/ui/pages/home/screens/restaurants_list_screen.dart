import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_restaurants_app/common/constants/assets.dart';
import 'package:test_restaurants_app/common/themes/app_colors.dart';
import 'package:test_restaurants_app/common/themes/app_text_styles.dart';

class RestaurantsListScreens extends StatelessWidget {
  const RestaurantsListScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 64.0, right: 16, left: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SearchField(),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return const RestaurantWidget();
              },
            ),
          )
        ],
      ),
    );
  }
}

class RestaurantWidget extends StatelessWidget {
  const RestaurantWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        constraints: const BoxConstraints(maxHeight: 42),
        hintText: 'Поиск',
        hintStyle: AppTextStyles.regular.copyWith(fontSize: 13, color: AppColors.grey_1),
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        prefixIcon: SvgPicture.asset(
          Assets.svgSearch,
          color: AppColors.grey_1,
          fit: BoxFit.scaleDown,
        ),
        border: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.grey_3, width: 1)),
      ),
    );
  }
}
