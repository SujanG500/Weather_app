import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sushi/models/weather_model.dart';
import 'package:sushi/services/weather_services.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //apikey
  final _weatherService = WeatherService('0611772954bb2a99dc936032db56a400');
  // current weather
  Weather? _weather;

  // fetch weather
  void _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  // initial state
  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? 'Loading...'),

            Lottie.asset('assets/cloudy.json'),

            Text('${_weather?.temperature.toString() ?? 'Loading...'}°C'),
          ],
        ),
      ),
    );
  }
}
