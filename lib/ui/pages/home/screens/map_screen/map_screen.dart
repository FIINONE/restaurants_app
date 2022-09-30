import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_restaurants_app/common/constants/assets.dart';
import 'package:test_restaurants_app/common/themes/app_colors.dart';
import 'package:test_restaurants_app/common/themes/app_text_styles.dart';
import 'package:test_restaurants_app/controllers/restaurants/restaurants_cubit.dart';
import 'package:test_restaurants_app/di.dart';
import 'package:test_restaurants_app/ui/pages/home/screens/map_screen/cubit/map_cubit.dart';
import 'package:test_restaurants_app/ui/pages/home/screens/map_screen/cubit/map_state.dart';
import 'package:test_restaurants_app/ui/widgets/search_field.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapCubit _mapCubit = MapCubit(sl.call());

  @override
  void initState() {
    super.initState();
    final cubit = context.read<RestaurantsAllCubit>();
    cubit.getRestaurants();
  }

  @override
  void dispose() {
    _mapCubit.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 5;

    return Scaffold(
      body: Stack(
        children: [
          BlocConsumer<RestaurantsAllCubit, RestaurantsState>(
            listener: (context, state) {
              if (state is RestaurantsData) {
                _mapCubit.initMap(state.restaurants.restaurants);
              }
            },
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
                  return BlocBuilder<MapCubit, MapState>(
                      bloc: _mapCubit,
                      builder: (context, state) {
                        return state.map(
                          loading: (loading) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          data: (data) {
                            return GoogleMap(
                              initialCameraPosition: _mapCubit.kTashkentCity,
                              zoomControlsEnabled: false,
                              markers: Set.from(data.markers),
                              onMapCreated: (controller) {
                                if (!_mapCubit.mapController.isCompleted) {
                                  _mapCubit.mapController.complete(controller);
                                }
                              },
                            );
                          },
                          error: (error) => Center(
                            child: Text(
                              error.message,
                              style: AppTextStyles.regular.copyWith(fontSize: 20),
                            ),
                          ),
                        );
                      });
                },
              );
            },
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: AppColors.white_1,
            ),
            margin: const EdgeInsets.only(top: 54.0, left: 16, right: 16),
            child: SearchField(
              onChanged: (value) => _mapCubit.search(search: value),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _mapCubit.getUserPosition();
        },
        child: SvgPicture.asset(Assets.svgGeo),
      ),
    );
  }
}
