import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<WeatherModel> getWeather(String cityName) async {
    var url = Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric');
    final response = await http.get(url);
    var responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(responseBody);
    } else {
      throw Exception('Failed to load weather :(');
    }
  }

  Future<String> getCurrentCity() async {
    //get permission from user
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    //fetch current location
    Position position = await Geolocator.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.high));

    //convert  the location into a list of placemark objects
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    //extract the city name from the first placement
    String? city = placemark[0].locality;

    return city ?? "";
  }
}
