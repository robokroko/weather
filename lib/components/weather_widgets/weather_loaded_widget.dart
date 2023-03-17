import 'package:flutter/material.dart';
import 'package:weather/components/basic_widgets/data_container_card.dart';
import 'package:weather/components/basic_widgets/weather_icon.dart';
import 'package:weather/models/open_weather_data.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:intl/intl.dart';
import 'package:weather/utils/constans.dart' as constans;

class WeatherLoadedWidget extends StatelessWidget {
  const WeatherLoadedWidget({
    super.key,
    required this.openWeatherData,
    required this.onRefresh,
  });

  final OpenWeatherData openWeatherData;
  final ValueGetter<Future<void>> onRefresh;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: onRefresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            clipBehavior: Clip.none,
            child: Center(
              child: Column(
                children: [
                  //Weather info
                  DataContainerCard(
                    openWeatherData: openWeatherData,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Today',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                            Text(
                              ' ${DateFormat.Hm().format(DateTime.now())}  ${DateFormat.yMMMd().format(DateTime.now())}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 25.0),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          openWeatherData.main != null && openWeatherData.main!.temp != null
                                              ? openWeatherData.main!.temp!.toInt().toString()
                                              : 'N/A',
                                          style: const TextStyle(
                                            fontSize: 80.0,
                                            color: Colors.white,
                                          )),
                                      Text(
                                        '°C',
                                        style: TextStyle(
                                          fontSize: 30.0,
                                          color: constans.appYellow,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            WeatherIcon(
                              iconCode: openWeatherData.weather != null && openWeatherData.weather!.first.icon != null
                                  ? openWeatherData.weather!.first.icon!
                                  : 'N/A',
                            ),
                          ],
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: constans.appYellow,
                                size: 20.0,
                              ),
                              Text(
                                '${openWeatherData.name}, ${openWeatherData.sys!.country}',
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            openWeatherData.weather!.first.main ?? '',
                            style: const TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ),
                  //Temperature
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: DataContainerCard(
                      openWeatherData: openWeatherData,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Temperature',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(top: 10.0),
                                    child: Text(
                                      'Averige',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10.0,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                            openWeatherData.main != null &&
                                                    openWeatherData.main!.tempMin != null &&
                                                    openWeatherData.main!.tempMax != null
                                                ? ((openWeatherData.main!.tempMin! + openWeatherData.main!.tempMax!) ~/
                                                        2)
                                                    .toString()
                                                : 'N/A',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30.0,
                                              color: Colors.white,
                                            )),
                                        Text(
                                          '°C',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: constans.appYellow,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(top: 10.0),
                                    child: Text(
                                      'Min',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10.0,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12.0),
                                    child: Row(
                                      children: [
                                        Text(
                                            openWeatherData.main != null && openWeatherData.main!.tempMin != null
                                                ? openWeatherData.main!.tempMin!.toInt().toString()
                                                : 'N/A',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30.0,
                                              color: Colors.white,
                                            )),
                                        Text(
                                          '°C',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: constans.appYellow,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(top: 10.0),
                                    child: Text(
                                      'Max',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10.0,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12.0),
                                    child: Row(
                                      children: [
                                        Text(
                                            openWeatherData.main != null && openWeatherData.main!.tempMax != null
                                                ? openWeatherData.main!.tempMax!.toInt().toString()
                                                : 'N/A',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30.0,
                                              color: Colors.white,
                                            )),
                                        Text(
                                          '°C',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: constans.appYellow,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Air condition
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: DataContainerCard(
                      openWeatherData: openWeatherData,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Text(
                                'Air Quality',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Column(
                                      children: [
                                        BoxedIcon(
                                          WeatherIcons.strong_wind,
                                          size: 30,
                                          color: constans.appYellow,
                                        ),
                                      ],
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        'Wind Speed',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10.0,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 12.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            openWeatherData.wind != null
                                                ? openWeatherData.wind!.speed.toString()
                                                : 'N/A',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                          Text(
                                            ' km/h',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: constans.appYellow,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Column(
                                      children: [
                                        BoxedIcon(
                                          WeatherIcons.wind_deg_45,
                                          size: 30,
                                          color: constans.appYellow,
                                        ),
                                      ],
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        'Wind Direction',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10.0,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 12.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            openWeatherData.wind != null ? openWeatherData.wind!.deg.toString() : 'N/A',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                          Text(
                                            ' °',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: constans.appYellow,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Column(
                                      children: [
                                        BoxedIcon(
                                          WeatherIcons.humidity,
                                          size: 30,
                                          color: constans.appYellow,
                                        ),
                                      ],
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        'Humidity',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10.0,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 12.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            openWeatherData.main != null
                                                ? openWeatherData.main!.humidity.toString()
                                                : 'N/A',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                          Text(
                                            ' %',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: constans.appYellow,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Column(
                                      children: [
                                        BoxedIcon(
                                          WeatherIcons.barometer,
                                          size: 30,
                                          color: constans.appYellow,
                                        ),
                                      ],
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        'Air Pressure',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10.0,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 12.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            openWeatherData.main != null
                                                ? (openWeatherData.main!.pressure! / 10).toString()
                                                : 'N/A',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                          Text(
                                            ' kPa',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: constans.appYellow,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
