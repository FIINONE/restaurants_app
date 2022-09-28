import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_restaurants_app/common/cubit/app_bloc_observer.dart';

import 'ui/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = AppBlocObserver();

  runApp(const MyApp());
}
