import 'package:intl/intl.dart';

class WeatherData {
  final String cityName;
  final double temperature;
  final String sunrise;
  final String sunset;

  WeatherData({
    required this.cityName,
    required this.temperature,
    required this.sunrise,
    required this.sunset,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    final DateFormat formatter = DateFormat('dd MMM HH:mm');
    return WeatherData(
        cityName: json['name'],
        temperature: (json['main']['temp'] - 273.15),
        sunrise: formatter.format(
            DateTime.fromMillisecondsSinceEpoch(json['sys']['sunrise'] * 1000)),
        sunset: formatter.format(
            DateTime.fromMillisecondsSinceEpoch(json['sys']['sunset'] * 1000)));
  }
}
