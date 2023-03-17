import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:weather/utils/constans.dart' as constans;

class WeatherIcon extends StatelessWidget {
  const WeatherIcon({super.key, required this.iconCode});
  final String iconCode;
  static const _iconSize = 80.0;

  @override
  Widget build(BuildContext context) {
    return BoxedIcon(
      getWeatherIcon(iconCode),
      size: _iconSize,
      color: constans.appYellow,
    );
  }

  IconData getWeatherIcon(String? iconCode) {
    switch (iconCode) {
      case '01d':
        return WeatherIcons.day_sunny;
      case '02d':
        return WeatherIcons.day_cloudy;
      case '03d':
        return WeatherIcons.cloud;
      case '04d':
        return WeatherIcons.cloudy;
      case '09d':
        return WeatherIcons.day_showers;
      case '10d':
        return WeatherIcons.day_rain;
      case '11d':
        return WeatherIcons.thunderstorm;
      case '13d':
        return WeatherIcons.snowflake_cold;
      case '50d':
        return WeatherIcons.dust;
      case '01n':
        return WeatherIcons.night_clear;
      case '02n':
        return WeatherIcons.night_alt_cloudy;
      case '03n':
        return WeatherIcons.cloud;
      case '04n':
        return WeatherIcons.cloudy;
      case '09n':
        return WeatherIcons.night_alt_showers;
      case '10n':
        return WeatherIcons.night_alt_rain;
      case '11n':
        return WeatherIcons.thunderstorm;
      case '13n':
        return WeatherIcons.snowflake_cold;
      case '50n':
        return WeatherIcons.dust;
      default:
        return WeatherIcons.na;
    }
  }
}
