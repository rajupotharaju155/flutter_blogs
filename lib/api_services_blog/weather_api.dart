import 'dart:convert';

import 'package:http/http.dart' as http;

import 'weather_model.dart';

Future<WeatherData> fetchWeatherData(String cityName) async {
  String APIKEY = "60f273b8318b84a2fc5f4d7b275633c4";
  final response = await http.get(Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$APIKEY'));
  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    print(jsonResponse);
    return WeatherData.fromJson(jsonResponse);
  } else {
    throw Exception('Failed to load weather data');
  }
}
