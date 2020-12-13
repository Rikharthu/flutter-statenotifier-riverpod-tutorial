import 'package:riverpod/all.dart';

import '../infrastructure/model/weather.dart';
import '../infrastructure/weather_repository.dart';

abstract class WeatherState {
  const WeatherState();
}

class WeatherInitial extends WeatherState {
  const WeatherInitial();
}

class WeatherLoading extends WeatherState {
  const WeatherLoading();
}

class WeatherLoaded extends WeatherState {
  final Weather weather;

  const WeatherLoaded(this.weather);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherLoaded && weather == other.weather;

  @override
  int get hashCode => weather.hashCode;
}

class WeatherError extends WeatherState {
  final String message;

  const WeatherError(this.message);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherError && message == other.message;

  @override
  int get hashCode => message.hashCode;
}

class WeatherNotifier extends StateNotifier<WeatherState> {
  final WeatherRepository _weatherRepository;

  WeatherNotifier(this._weatherRepository) : super(WeatherInitial());

  Future<void> getWeather(String cityName) async {
    state = WeatherLoading();

    try {
      final weather = await _weatherRepository.fetchWeather(cityName);
      state = WeatherLoaded(weather);
    } on NetworkException {
      state = WeatherError("Couldn't fetch weather. Is the device online?");
    }
  }
}
