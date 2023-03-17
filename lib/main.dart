import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/blocs/bloc/gps/gps_bloc.dart';
import 'package:weather/blocs/cubit/weather/weather_cubit.dart';
import 'package:weather/providers/api_provider.dart';
import 'package:weather/screens/weather_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherCubit>(
          create: (context) => WeatherCubit(apiProvider: ApiProvider()),
        ),
        BlocProvider<GpsBloc>(
          create: (context) => GpsBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Weather App',
        theme: ThemeData(fontFamily: 'Montserrat'),
        home: const WeatherScreen(),
      ),
    );
  }
}
