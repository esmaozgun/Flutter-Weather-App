import 'dart:convert';
import '../model/weather_model.dart';
import '../constants.dart';
import 'http_service.dart';

class WeatherService {
  final HttpService _httpService = HttpService();

  Future<Weather?> fetchWeather(String city) async {
    final url = '${ApiConstants.baseUrl}/weather?q=$city&appid=${ApiConstants.apiKey}&units=metric&lang=tr';
    final response = await _httpService.getRequest(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return Weather.fromJson(data);
    } else {
      return null;
    }
  }
}


