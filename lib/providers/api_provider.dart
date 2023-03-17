import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather/models/city.dart';
import 'package:weather/models/open_weather_data.dart';
import 'package:location/location.dart';

class ApiProvider {
  final apiKey = '3a65c87004a68507506402ea1bec8b6d';
  final openWeatherDataURL = 'https://api.openweathermap.org/data/2.5/weather';
  final openWeatherGeocodindURL = 'http://api.openweathermap.org/geo/1.0/direct';

  Future<City> searchCities(String cityName) async {
    final response = await http.get(Uri.parse('$openWeatherGeocodindURL?q=$cityName&limit=3&appid=$apiKey'));
    if (response.statusCode != 200) {
      throw Exception('Error getting city from name: $cityName');
    }
    if (response.body == "[]") {
      throw Exception('Error getting cities from name: $cityName');
    }
    final cityJson = jsonDecode(response.body);
    List<City> cities = List<City>.from(cityJson.map((model) => City.fromJson(model)));
    return cities.first;
  }

  Future<LocationData> getLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        throw Exception('Turn on GPS!');
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        throw Exception('Turn on GPS!');
      }
    }

    locationData = await location.getLocation();
    return locationData;
  }

  Future<OpenWeatherData> getLocationAndFetchWeather() async {
    var locationData = await getLocation();

    final response = await http.get(Uri.parse(
        '$openWeatherDataURL?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=$apiKey&units=metric'));
    if (response.statusCode != 200) {
      throw Exception('Error getting weather from location coordinates: $locationData');
    }
    return OpenWeatherData.fromJson(jsonDecode(response.body));
  }

  Future<OpenWeatherData> fetchWeather(Coord location) async {
    final response = await http
        .get(Uri.parse('$openWeatherDataURL?lat=${location.lat}&lon=${location.lon}&appid=$apiKey&units=metric'));
    if (response.statusCode != 200) {
      throw Exception('Error getting weather from location: $location');
    }
    return OpenWeatherData.fromJson(jsonDecode(response.body));
  }
}
