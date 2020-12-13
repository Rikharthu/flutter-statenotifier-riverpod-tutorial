import 'package:riverpod/riverpod.dart';
import 'package:riverpod_statenotifier_tutorial/application/weather_notifier.dart';

import 'infrastructure/weather_repository.dart';

final weatherRepositoryProvider = Provider<WeatherRepository>(
  (ref) => FakeWeatherRepository(),
);

final weatherNotifierProvider = StateNotifierProvider(
  (ref) => WeatherNotifier(ref.watch(weatherRepositoryProvider)),
);
