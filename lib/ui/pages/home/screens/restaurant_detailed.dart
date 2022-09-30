import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:test_restaurants_app/common/constants/assets.dart';
import 'package:test_restaurants_app/common/themes/app_colors.dart';
import 'package:test_restaurants_app/common/themes/app_text_styles.dart';
import 'package:test_restaurants_app/controllers/favorite_cubit.dart';
import 'package:test_restaurants_app/controllers/restaurant_detail/restaurant_detail_state.dart';
import 'package:test_restaurants_app/controllers/restaurant_detail/restaurant_detailed_cubit.dart';
import 'package:test_restaurants_app/controllers/restaurants/restaurants_cubit.dart';
import 'package:test_restaurants_app/data/models/image_model.dart';
import 'package:test_restaurants_app/data/models/restaurant_model.dart';
import 'package:test_restaurants_app/ui/widgets/image_view_builder.dart';

class RestaurantDetailedPage extends StatelessWidget {
  const RestaurantDetailedPage({Key? key}) : super(key: key);

  static final images = [
    Assets.imagesFoto1,
    Assets.imagesFoto2,
    Assets.imagesFoto3,
  ];

  void _imageGenerate(RestaurantModel model) {
    if (model.images.isEmpty) {
      final imagesModel =
          List.generate(3, (index) => ImageModel(id: index, url: images[index], restaurantId: model.id));
      model.images.addAll(imagesModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantDetailedCubit, RestaurantDetaildState>(builder: (context, state) {
      return state.map(
        loading: (loading) => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error) => Center(child: Text(error.message)),
        data: (data) {
          final restaurant = data.restaurant;
          _imageGenerate(restaurant);
          final size = MediaQuery.of(context).size;
          final width = size.width;
          final height = size.height * 0.3;

          return Scaffold(
            appBar: AppBar(
              title: Text(
                restaurant.title,
                style: AppTextStyles.medium.copyWith(color: Colors.white),
              ),
              backgroundColor: Colors.transparent,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  )),
              actions: [
                IconButton(
                    onPressed: () async {
                      final favCubit = context.read<FavoriteCubit>();
                      final restAllCubit = context.read<RestaurantsAllCubit>();
                      final restDetailedCubit = context.read<RestaurantDetailedCubit>();

                      final result = await favCubit.updateFavorite(
                          isFavorite: restaurant.isFavourite, restaurantID: restaurant.id);

                      if (result) {
                        restAllCubit.updateState(restaurant.id);
                        restDetailedCubit.updateState();
                      }
                    },
                    icon: SvgPicture.asset(
                      restaurant.isFavourite ? Assets.svgLikeOn : Assets.svgLikeOff,
                      color: restaurant.isFavourite ? AppColors.red : Colors.white,
                      height: 18,
                      width: 20,
                    )),
              ],
            ),
            extendBodyBehindAppBar: true,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ImageViewBuilder(width: width, height: height, restaurantImages: restaurant.images),
                    Container(
                      height: height / 2,
                      decoration: const BoxDecoration(gradient: AppColors.linear),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
                  child: _DecriptionText(description: restaurant.description),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Divider(
                    indent: 0,
                    endIndent: 0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16),
                  child: Column(
                    children: [
                      _RowItem(
                          text: 'Работаем с ${restaurant.schedule.opening} до ${restaurant.schedule.closing}',
                          svgPath: Assets.svgTime),
                      Padding(
                        padding: const EdgeInsets.only(top: 14.0),
                        child: _RowItem(text: restaurant.coords.addressName, svgPath: Assets.svgLocation),
                      ),
                    ],
                  ),
                ),
                Divider(
                  indent: 0,
                  endIndent: 0,
                ),
              ],
            ),
          );
        },
      );
    });
  }
}

class _RowItem extends StatelessWidget {
  const _RowItem({
    Key? key,
    required this.text,
    required this.svgPath,
  }) : super(key: key);

  final String text;
  final String svgPath;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(svgPath),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              text,
              style: AppTextStyles.regular.copyWith(fontSize: 16, height: 1.5),
            ),
          ),
        )
      ],
    );
  }
}

class _DecriptionText extends StatefulWidget {
  const _DecriptionText({
    Key? key,
    required this.description,
  }) : super(key: key);

  final String description;

  @override
  State<_DecriptionText> createState() => _DecriptionTextState();
}

class _DecriptionTextState extends State<_DecriptionText> {
  bool maxLinesEnabled = true;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final span = TextSpan(
          text: widget.description,
          style: AppTextStyles.regular.copyWith(fontSize: 16, height: 1.5),
        );
        final tp = TextPainter(text: span, textDirection: TextDirection.ltr);
        tp.layout(maxWidth: constraints.maxWidth);
        final numLines = tp.computeLineMetrics().length;

        if (numLines > 2 && maxLinesEnabled) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Описание',
                style: AppTextStyles.regular.copyWith(
                  color: AppColors.grey_1,
                  height: 1.5,
                ),
              ),
              Text(
                widget.description,
                maxLines: 2,
                style: AppTextStyles.regular.copyWith(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    maxLinesEnabled = false;
                  });
                },
                child: Text(
                  'Подробнее',
                  style: AppTextStyles.regular.copyWith(
                    fontSize: 13,
                    height: 1.5,
                    decoration: TextDecoration.underline,
                    color: AppColors.blue,
                  ),
                ),
              ),
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Описание',
                style: AppTextStyles.regular.copyWith(
                  color: AppColors.grey_1,
                  height: 1.5,
                ),
              ),
              Text(
                widget.description,
                maxLines: numLines,
                style: AppTextStyles.regular.copyWith(fontSize: 16, height: 1.5),
              ),
            ],
          );
        }
      },
    );
  }
}
