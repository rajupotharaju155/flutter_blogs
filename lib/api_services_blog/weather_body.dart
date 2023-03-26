import 'package:flutter/material.dart';
import 'package:ui_app/api_services_blog/weather_api.dart';
import 'package:ui_app/api_services_blog/weather_model.dart';

class WeatherPage extends StatelessWidget {
  final String cityName;

  const WeatherPage({required this.cityName});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WeatherData>(
      future: fetchWeatherData(cityName),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                leading: const Text('City Name'),
                trailing: Text(snapshot.data!.cityName),
              ),
              ListTile(
                leading: const Text('Temperature'),
                trailing:
                    Text('${snapshot.data!.temperature.toStringAsFixed(1)} °C'),
              ),
              ListTile(
                leading: const Text('Sunrise'),
                trailing: Text(snapshot.data!.sunrise.toString()),
              ),
              ListTile(
                leading: const Text('Sunset'),
                trailing: Text(snapshot.data!.sunset.toString()),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return const Text('Failed to load weather data');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
