import 'package:flutter/material.dart';
import '../services/weather_service.dart';
import '../model/weather_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _selectedCity;
  WeatherService _weatherService = WeatherService();
  Weather? _weatherData;
  bool _isLoading = false;

  void _fetchWeatherData() async {
    if (_selectedCity != null) {
      setState(() {
        _isLoading = true;
      });

      final data = await _weatherService.fetchWeather(_selectedCity!);

      setState(() {
        _weatherData = data;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton<String>(
                value: _selectedCity,
                hint: Text('Şehir seçin'),
                items: ['Istanbul', 'Ankara', 'Izmir'].map((String city) {
                  return DropdownMenuItem<String>(
                    value: city,
                    child: Text(
                      city,
                      style: TextStyle(fontSize: 18.0),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedCity = newValue;
                  });
                },
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: _fetchWeatherData,
                child: Text('Hava Durumunu Gör', style: TextStyle(fontSize: 18.0)),
              ),
              SizedBox(height: 40),
              _isLoading
                  ? CircularProgressIndicator()
                  : _weatherData != null
                  ? Column(
                children: [
                  Text(
                    'Sıcaklık: ${_weatherData!.temp}°C',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Text(
                    'Durum: ${_weatherData!.description}',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Text(
                    'Hissedilen: ${_weatherData!.feelsLike}°C',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Text(
                    'Minimum Sıcaklık: ${_weatherData!.tempMin}°C',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Text(
                    'Maximum Sıcaklık: ${_weatherData!.tempMax}°C',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Text(
                    'Basınç: ${_weatherData!.pressure} hPa',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Text(
                    'Nem: ${_weatherData!.humidity}%',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ],
              )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
