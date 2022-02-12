import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather_firebase/domain/api_client/api_client.dart';
import 'package:weather_firebase/domain/entity/weather.dart';

class MainWeatherScreenWidgetModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  WeatherApi? _weatherData;
  WeatherApi? get weatherData => _weatherData;
  var date = '';
  String errorMessage = '';
  String snackMessage = '';

  MainWeatherScreenWidgetModel() {
    _stringFromDate();
    determinePosition();
  }

  String _stringFromDate() {
    final _dateFormat = DateFormat('', 'ru').add_yMd();
    date = _dateFormat.format(DateTime.now());
    return date;
  }

  Future<void> _loadWeather(String lat, String lon) async {
    try {
      errorMessage = '';
      _weatherData = await _apiClient.weatherLoad(lat, lon);
      notifyListeners();
    } catch (_) {
      errorMessage = 'Ошибка соединения';
      notifyListeners();
    }
  }

  Future<void> addDataWeather() async {
    if (weatherData?.main.temp == null) return;
    final _dateFormat = DateFormat('', 'ru').add_yMd().add_Hms();
    final dateNow = _dateFormat.format(DateTime.now());
    final addbase = FirebaseFirestore.instance.collection('weather_item');
    addbase.add(<String, dynamic>{
      'temp': weatherData?.main.temp ?? '',
      'speed': weatherData?.wind.speed ?? '',
      'humidity': weatherData?.main.humidity ?? '',
      'data': dateNow,
    });
    snackMessage = 'Данные добавлены';
    notifyListeners();
  }

  Future<void> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    snackMessage = '';
    errorMessage = '';
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      errorMessage = 'Службы геолокации отключены';
      notifyListeners();
      return;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        errorMessage = 'Разрешения на местоположение запрещены';
        notifyListeners();
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      errorMessage = 'Разрешения на местоположение навсегда запрещены';
      notifyListeners();
      return;
    }
    final position = await Geolocator.getCurrentPosition();
    final lat = position.latitude.toString();
    final lon = position.longitude.toString();

    await _loadWeather(lat, lon);
    return;
  }
}
