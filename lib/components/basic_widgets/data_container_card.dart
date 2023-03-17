import 'package:flutter/material.dart';
import 'package:weather/models/open_weather_data.dart';

class DataContainerCard extends StatelessWidget {
  const DataContainerCard({
    Key? key,
    this.openWeatherData,
    required this.child,
  }) : super(key: key);

  final OpenWeatherData? openWeatherData;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 30,
              offset: const Offset(2, 2),
            )
          ],
          borderRadius: BorderRadius.circular(20.0),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withOpacity(0.1),
              Colors.white.withOpacity(0.2),
            ],
            stops: const [
              0.0,
              4.0,
            ],
          ),
        ),
        padding: const EdgeInsets.all(20.0),
        child: child);
  }
}
