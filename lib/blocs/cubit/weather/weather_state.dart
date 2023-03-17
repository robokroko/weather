import 'package:equatable/equatable.dart';
import 'package:weather/models/errors/custom_error.dart';
import 'package:weather/models/open_weather_data.dart';

enum WeatherStatus {
  initial,
  loading,
  loaded,
  error,
}

class WeatherState extends Equatable {
  final WeatherStatus status;
  final OpenWeatherData openWeatherData;
  final CustomError error;
  const WeatherState({
    required this.status,
    required this.openWeatherData,
    required this.error,
  });

  WeatherState copyWith({
    WeatherStatus? status,
    OpenWeatherData? openWeatherData,
    bool? isWetherGetByGPS,
    CustomError? error,
  }) {
    return WeatherState(
      status: status ?? this.status,
      openWeatherData: openWeatherData ?? this.openWeatherData,
      error: error ?? this.error,
    );
  }

  factory WeatherState.initial() {
    return WeatherState(
        status: WeatherStatus.initial,
        openWeatherData: OpenWeatherData(),
        error: const CustomError());
  }

  @override
  List<Object> get props => [status, openWeatherData];
}
