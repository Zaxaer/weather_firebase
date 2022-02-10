import 'dart:convert';
import 'dart:io';

import 'package:weather_firebase/domain/entity/weather.dart';

enum ApiClientExceptionTipe { network }

class ApiClientException implements Exception {
  final ApiClientExceptionTipe type;

  ApiClientException(this.type);
}

class ApiClient {
  final _client = HttpClient();
  static const _host = 'https://api.openweathermap.org/data/2.5/weather?';
  static const _apiKey = '5b36dff0bbb45d9c58f46f822ff3a37d';
  static const metric = '&units=metric';

  Future<T> _get<T>(String lat, String lon, String apiKey,
      T Function(dynamic json) parser) async {
    try {
      final url = Uri.parse('$_host$lat$lon$metric$apiKey');
      final request = await _client.getUrl(url);
      final response = await request.close();
      final dynamic json = (await response.jsonDecode());
      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionTipe.network);
    }
  }

  Future<WeatherApi> weatherLoad(String lat, String lon) async {
    // ignore: prefer_function_declarations_over_variables
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = WeatherApi.fromJson(jsonMap);
      return response;
    };
    final result = _get(
      'lat=$lat',
      '&lon=$lon',
      '&appid=$_apiKey',
      parser,
    );
    return result;
  }
}

extension HttpClientResponseJsonDecode on HttpClientResponse {
  Future<dynamic> jsonDecode() async {
    return transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then<dynamic>((v) => json.decode(v));
  }
}
