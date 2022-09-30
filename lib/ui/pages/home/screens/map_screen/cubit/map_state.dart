import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapState {}

class MapLoading extends MapState {}

class MapData extends MapState {
  final List<Marker> markers;

  MapData({
    required this.markers,
  });
}

class MapError extends MapState {
  final String message;
  MapError({
    required this.message,
  });
}

extension MapStateUnion on MapState {
  T map<T>({
    required T Function(MapLoading) loading,
    required T Function(MapData) data,
    required T Function(MapError) error,
  }) {
    if (this is MapLoading) return loading(this as MapLoading);
    if (this is MapData) return data(this as MapData);
    if (this is MapError) return error(this as MapError);

    throw AssertionError('Union does not match any possible values');
  }
}
