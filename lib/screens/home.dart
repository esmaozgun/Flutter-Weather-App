import 'package:flutter/material.dart';
import 'package:weatherapp/services/weather_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _selectedCity;
  final List<String> _cities = ['İstanbul', 'Ankara', 'İzmir'];
  Map<String, dynamic>? _weatherData;

  final WeatherService _weatherService = WeatherService();

  void _getData() async {
    if (_selectedCity != null) {
      final data = await _weatherService.fetchWeather(_selectedCity!);
      if (data != null) {
        setState(() {
          _weatherData = data;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hava durumu verisi alınamadı')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lütfen bir şehir seçin')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Şehir Seçimi'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 300, // Dropdown genişliği
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: const Text('Şehir seçin'),
                    value: _selectedCity,
                    isExpanded: true,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCity = newValue;
                        _weatherData = null;
                      });
                    },
                    items: _cities.map<DropdownMenuItem<String>>((String city) {
                      return DropdownMenuItem<String>(
                        value: city,
                        child: Text(city),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 250, // Buton genişliği
                height: 50, // Buton yüksekliği
                child: ElevatedButton(
                  onPressed: _getData,
                  child: const Text(
                    'Hava Durumunu Gör',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              _weatherData != null
                  ? Column(
                children: [
                  Text(
                    'Sıcaklık: ${_weatherData!['main']['temp']}°C',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Durum: ${_weatherData!['weather'][0]['description']}',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
