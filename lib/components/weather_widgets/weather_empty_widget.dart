import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/blocs/cubit/weather/weather_cubit.dart';
import 'package:weather/screens/add_location_screen.dart';
import 'package:weather/utils/constans.dart' as constans;

class WeatherEmptyWidget extends StatefulWidget {
  const WeatherEmptyWidget({super.key});

  @override
  State<WeatherEmptyWidget> createState() => _WeatherEmptyWidgetState();
}

class _WeatherEmptyWidgetState extends State<WeatherEmptyWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 120.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: constans.appYellow,
              fontSize: 30.0,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: SizedBox(
              width: 240.0,
              child: Text(
                'For up-to-date weather information please, add a city!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
              height: 70.0,
              width: 200.0,
              color: Colors.transparent,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: constans.appYellow,
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                    side: const BorderSide(
                      width: 1.0,
                    ),
                  ),
                ),
                onPressed: () async {
                  var location = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AddLocationScreen(),
                    ),
                  );
                  if (mounted) {
                    if (location != null) {
                      context.read<WeatherCubit>().fetchWeather(location, context);
                    }
                  }
                },
                child: const Text(
                  'Add City',
                  style: TextStyle(
                    color: Color.fromARGB(255, 15, 14, 49),
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
