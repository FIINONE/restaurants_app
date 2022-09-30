import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_restaurants_app/common/constants/assets.dart';
import 'package:test_restaurants_app/data/models/restaurant_model.dart';
import 'package:test_restaurants_app/data/repository/restaurant_repo.dart';
import 'package:test_restaurants_app/ui/pages/home/screens/map_screen/cubit/map_state.dart';
import 'dart:ui' as ui;

class MapCubit extends Cubit<MapState> {
  final RestaurantsRepo _repo;

  MapCubit(this._repo) : super(MapLoading());

  Timer? _bouncing;

  final List<Marker> _markers = [];
  BitmapDescriptor? targetIcon;
  BitmapDescriptor? positionIcon;
  final Completer<GoogleMapController> mapController = Completer();

  final CameraPosition kTashkentCity = const CameraPosition(
    target: LatLng(41.2646, 69.2163),
    zoom: 14.4746,
  );

  Future<void> initMap(List<RestaurantModel> restaurants) async {
    emit(MapLoading());

    await _initIcon();
    _markers.clear();

    for (var rest in restaurants) {
      _markers.add(
        Marker(
          markerId: MarkerId(rest.coordsId.toString()),
          position: LatLng(rest.coords.latitude, rest.coords.longitude),
          infoWindow: InfoWindow(
            title: rest.title,
          ),
        ),
      );
    }
    emit(MapData(markers: _markers));
  }

  Future<void> getUserPosition() async {
    final position = await _getUserCurrentLocation();
    final index = _markers.indexWhere((element) => element.markerId.value == 'my_position');

    if (index.isNegative) {
      _markers.add(Marker(
        markerId: const MarkerId('my_position'),
        position: LatLng(position.latitude, position.longitude),
        icon: positionIcon!,
        infoWindow: const InfoWindow(
          title: 'Я',
        ),
      ));
    } else {
      _markers[index] = Marker(
        markerId: const MarkerId('my_position'),
        position: LatLng(position.latitude, position.longitude),
        icon: positionIcon!,
        infoWindow: const InfoWindow(
          title: 'Я',
        ),
      );
    }

    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 14,
    );

    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    emit(MapData(markers: _markers));
  }

  Future<void> search({required String search}) async {
    _bouncing?.cancel();

    _bouncing = Timer(const Duration(seconds: 2), () async {
      final result = await _repo.getRestaurants(search: search);

      result.fold(
        (failure) {},
        (restaurants) async {
          if (restaurants.restaurants.isNotEmpty) {
            final rest = restaurants.restaurants.firstWhere((rest) {
              for (var marker in _markers) {
                return rest.coordsId.toString() == marker.markerId.value;
              }
              return false;
            });

            CameraPosition cameraPosition = CameraPosition(
              target: LatLng(rest.coords.latitude, rest.coords.longitude),
              zoom: 14,
            );

            final GoogleMapController controller = await mapController.future;
            controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
          }
        },
      );
    });
  }

  Future<Position> _getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value) {}).onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  Future<void> _initIcon() async {
    final targetData = await _getBytesFromAsset(Assets.imagesTarget, 84);
    final positionIconData = await _getBytesFromAsset(Assets.imagesPosition, 28);
    targetIcon = BitmapDescriptor.fromBytes(targetData);
    positionIcon = BitmapDescriptor.fromBytes(positionIconData);
  }

  static Future<Uint8List> _getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }
}
