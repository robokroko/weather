import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:weather/blocs/cubit/weather/weather_cubit.dart';
import 'package:weather/blocs/cubit/weather/weather_state.dart';
import 'package:weather/components/weather_widgets/weather_empty_widget.dart';
import 'package:weather/components/weather_widgets/weather_loaded_widget.dart';

import 'package:weather/screens/add_location_screen.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<StatefulWidget> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [Color.fromARGB(255, 15, 14, 49), Color.fromARGB(255, 44, 43, 73)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: const Text('Weather'),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
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
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: BlocConsumer<WeatherCubit, WeatherState>(
              listener: (context, state) {
                if (state.status == WeatherStatus.error) {}
              },
              builder: (context, state) {
                if (state.status == WeatherStatus.initial) {
                  return const Center(child: WeatherEmptyWidget());
                }
                if (state.status == WeatherStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.status == WeatherStatus.loaded) {
                  return WeatherLoadedWidget(
                    openWeatherData: state.openWeatherData,
                    onRefresh: () async {
                      return context.read<WeatherCubit>().refreshWeather(context);
                    },
                  );
                }
                if (state.status == WeatherStatus.error) {
                  return const Center(
                    child: Text(
                      'Something went wrong',
                    ),
                  );
                } else {
                  return const Center(
                    child: Text(
                      'Something went wrong',
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
