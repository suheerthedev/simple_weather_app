import 'dart:convert';

import 'package:weather_app/models/weather_model.dart';

import 'package:http/http.dart' as http;

class GetWeatherApi {
  static const baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  GetWeatherApi(this.apiKey);

  Future<WeatherModel> getWeatherApi(String cityName) async {
    var url = Uri.parse('$baseUrl?q=$cityName&appid=$apiKey&units=metric');
    var reponse = await http.get(url);
    var reponseBody = jsonDecode(reponse.body);

    print("Reponse Status: ${reponse.statusCode}");
    print("Reponse Body: $reponseBody");

    if (reponse.statusCode == 200) {
      return WeatherModel.fromJson(reponseBody);
    } else {
      throw Exception("Failed to load weather :(");
    }
  }
}
