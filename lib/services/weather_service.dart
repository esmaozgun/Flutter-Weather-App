import 'dart:convert';
import 'http_service.dart';

class WeatherService {
  final String _apiKey = 'add your api key here :)';
  final HttpService _httpService = HttpService();

  Future<Map<String, dynamic>?> fetchWeather(String city) async {
    final String apiUrl = 'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$_apiKey&units=metric&lang=tr';
    final response = await _httpService.getRequest(apiUrl);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }
}
