import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/blocs/bloc/gps/gps_bloc.dart';
import 'package:weather/blocs/cubit/weather/weather_state.dart';
import 'package:weather/models/errors/custom_error.dart';
import 'package:weather/models/open_weather_data.dart';
import 'package:weather/providers/api_provider.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final ApiProvider apiProvider;

  WeatherCubit({required this.apiProvider}) : super(WeatherState.initial());

  Future<void> refreshWeather(BuildContext context) async {
    OpenWeatherData openWeatherData;
    bool isWeatherGetByGPS = context.read<GpsBloc>().state.isGpsAllowed;
    if (state.status != WeatherStatus.loaded) return;
    try {
      if (!isWeatherGetByGPS) {
        openWeatherData = await apiProvider.fetchWeather(state.openWeatherData.coord!);
      } else {
        openWeatherData = await apiProvider.getLocationAndFetchWeather();
      }

      emit(
        state.copyWith(
          status: WeatherStatus.loaded,
          openWeatherData: openWeatherData,
        ),
      );
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: WeatherStatus.error,
        error: e,
      ));
    }
  }

  Future<void> fetchWeather(dynamic cityName, BuildContext context) async {
    bool isWeatherGetByGPS = context.read<GpsBloc>().state.isGpsAllowed;

    emit(state.copyWith(status: WeatherStatus.loading));
    try {
      if (!isWeatherGetByGPS) {
        await apiProvider.fetchWeather(cityName).then((openWeatherData) {
          emit(state.copyWith(
            status: WeatherStatus.loaded,
            openWeatherData: openWeatherData,
          ));
        });
      } else {
        await apiProvider.getLocationAndFetchWeather().then((openWeatherData) {
          emit(state.copyWith(
            status: WeatherStatus.loaded,
            openWeatherData: openWeatherData,
          ));
        });
      }
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: WeatherStatus.error,
        error: e,
      ));
    }
  }
}
