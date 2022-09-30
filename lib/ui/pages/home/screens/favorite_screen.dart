import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_restaurants_app/common/constants/assets.dart';
import 'package:test_restaurants_app/controllers/favorite_cubit.dart';
import 'package:test_restaurants_app/data/models/image_model.dart';
import 'package:test_restaurants_app/data/models/restaurant_model.dart';
import 'package:test_restaurants_app/ui/widgets/restaurant_widget.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();

    final cubit = context.read<FavoriteCubit>();
    cubit.getFavoriteRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, List<RestaurantModel>?>(
      builder: (context, restaurants) {
        if (restaurants == null) {
          return const Center(child: CircularProgressIndicator(),);
        }
        
        if (restaurants.isEmpty) {
          return const Center(
            child: Text('Cписок пуст'),
          );
        }

        return ListView.separated(
          itemCount: restaurants.length,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          separatorBuilder: (context, index) => const SizedBox(height: 20),
          itemBuilder: (context, index) {
            final restaurant = restaurants[index];
            _addImage(restaurant, index);

            return RestaurantWidget(restaurant: restaurant);
          },
        );
      },
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
