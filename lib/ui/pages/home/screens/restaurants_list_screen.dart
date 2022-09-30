import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:test_restaurants_app/common/constants/assets.dart';
import 'package:test_restaurants_app/common/themes/app_text_styles.dart';
import 'package:test_restaurants_app/controllers/restaurants/restaurants_cubit.dart';
import 'package:test_restaurants_app/data/models/image_model.dart';
import 'package:test_restaurants_app/data/models/restaurant_model.dart';
import 'package:test_restaurants_app/ui/widgets/restaurant_widget.dart';
import 'package:test_restaurants_app/ui/widgets/search_field.dart';

class RestaurantsListScreens extends StatefulWidget {
  const RestaurantsListScreens({Key? key}) : super(key: key);

  @override
  State<RestaurantsListScreens> createState() => _RestaurantsListScreensState();
}

class _RestaurantsListScreensState extends State<RestaurantsListScreens> {
  @override
  void initState() {
    super.initState();

    final cubit = context.read<RestaurantsAllCubit>();
    cubit.getRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RestaurantsAllCubit>();
    final height = MediaQuery.of(context).size.height / 5;

    return Padding(
      padding: const EdgeInsets.only(top: 64.0, right: 16, left: 16),
      child: Column(
        children: [
          SearchField(
            onChanged: (value) {
              cubit.getRestaurants(search: value);
            },
          ),
          BlocBuilder<RestaurantsAllCubit, RestaurantsState>(
            builder: (context, state) {
              return state.map(
                loading: (loading) => Padding(
                  padding: EdgeInsets.only(top: height),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                error: (error) {
                  return Center(
                    child: Text(
                      error.message,
                      style: AppTextStyles.regular.copyWith(fontSize: 20),
                    ),
                  );
                },
                data: (data) {
                  final restaurantsAll = data.restaurants;
                  final restaurants = restaurantsAll.restaurants;

                  return Expanded(
                    child: ListView.separated(
                      itemCount: restaurants.length,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      separatorBuilder: (context, index) => const SizedBox(height: 20),
                      itemBuilder: (context, index) {
                        final restaurant = restaurants[index];
                        _addImage(restaurant, index);

                        return RestaurantWidget(restaurant: restaurant);
                      },
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  static final images = [
    Assets.imagesFoto1,
    Assets.imagesFoto2,
    Assets.imagesFoto3,
  ];

  void _addImage(RestaurantModel model, int index) {
    if (model.images.isEmpty && index < 3) {
      model.images.add(ImageModel(id: index, url: images[index], restaurantId: model.id));
    }
  }
}
