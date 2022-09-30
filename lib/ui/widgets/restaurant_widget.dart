import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_restaurants_app/common/constants/assets.dart';
import 'package:test_restaurants_app/common/routes/app_routes.dart';
import 'package:test_restaurants_app/common/themes/app_colors.dart';
import 'package:test_restaurants_app/common/themes/app_text_styles.dart';
import 'package:test_restaurants_app/controllers/favorite_cubit.dart';
import 'package:test_restaurants_app/controllers/restaurant_detail/restaurant_detailed_cubit.dart';
import 'package:test_restaurants_app/controllers/restaurants/restaurants_cubit.dart';
import 'package:test_restaurants_app/data/models/restaurant_model.dart';
import 'package:test_restaurants_app/ui/widgets/image_view_builder.dart';

class RestaurantWidget extends StatelessWidget {
  const RestaurantWidget({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  final RestaurantModel restaurant;

  @override
  Widget build(BuildContext context) {
    final restAllCubit = context.read<RestaurantsAllCubit>();
    final restDatailedCubit = context.read<RestaurantDetailedCubit>();
    final width = MediaQuery.of(context).size.width - 16;

    return InkWell(
      onTap: () {
        restDatailedCubit.getRestaurantDetailed(restaurant.id);
        Navigator.pushNamed(context, AppRoutesName.restaurantDetailed);
      },
      child: Ink(
        height: 234,
        decoration: BoxDecoration(
          color: AppColors.white_1,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageViewBuilder(
              restaurantImages: restaurant.images,
              height: 150,
              width: width,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, left: 16, right: 9, bottom: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant.title,
                          style: AppTextStyles.bold.copyWith(fontSize: 16),
                        ),
                        Text(
                          restaurant.description,
                          maxLines: 1,
                          style: AppTextStyles.regular.copyWith(
                            fontSize: 13,
                            color: AppColors.grey_1,
                            height: 1.5,
                          ),
                        ),
                        Text(
                          restaurant.coords.addressName,
                          maxLines: 1,
                          style: AppTextStyles.regular.copyWith(
                            fontSize: 13,
                            color: AppColors.grey_1,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final favCubit = context.read<FavoriteCubit>();

                      final result = await favCubit.updateFavorite(
                          isFavorite: restaurant.isFavourite, restaurantID: restaurant.id);

                      if (result) {
                        restAllCubit.updateState(restaurant.id);
                      }
                    },
                    borderRadius: BorderRadius.circular(50),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: SvgPicture.asset(restaurant.isFavourite ? Assets.svgLikeOn : Assets.svgLikeOff),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
