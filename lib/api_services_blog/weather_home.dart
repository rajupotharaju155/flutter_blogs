import 'package:flutter/material.dart';
import 'package:ui_app/api_services_blog/weather_model.dart';

import 'weather_api.dart';

class WeatherHome extends StatefulWidget {
  const WeatherHome({super.key});
  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  late String _cityName = '';
  Future<WeatherData>? futureDate;

  void getWeatherData() {
    futureDate = fetchWeatherData(_cityName);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
                child: Column(
              children: [
                TextField(
                  onChanged: (value) => _cityName = value.trim(),
                ),
                ElevatedButton(
                    onPressed: getWeatherData,
                    child: const Center(
                      child: Text("Submit"),
                    )),
              ],
            )),
            Container(
                child: FutureBuilder<WeatherData>(
              future: futureDate,
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
                        trailing: Text(
                            '${snapshot.data!.temperature.toStringAsFixed(1)} °C'),
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
            ))
          ],
        ),
      ),
    );
  }
}
