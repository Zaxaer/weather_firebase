import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

@JsonSerializable(explicitToJson: true)
class WeatherApi {
  final Coord coord;
  final List<Weather> weather;
  final String base;
  final Main main;
  final int visibility;
  final Wind wind;
  final Clouds clouds;
  final int dt;
  final Sys sys;
  final int timezone;
  final int id;
  final String name;
  final int cod;
  WeatherApi({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });
  factory WeatherApi.fromJson(Map<String, dynamic> json) =>
      _$WeatherApiFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherApiToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Coord {
  final double lon;
  final double lat;
  Coord({
    required this.lon,
    required this.lat,
  });
  factory Coord.fromJson(Map<String, dynamic> json) => _$CoordFromJson(json);

  Map<String, dynamic> toJson() => _$CoordToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Weather {
  final int id;
  final String main;
  final String description;
  final String icon;
  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });
  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Main {
  final double temp;
  final double feels_like;
  final double temp_min;
  final double temp_max;
  final int pressure;
  final int humidity;
  Main({
    required this.temp,
    required this.feels_like,
    required this.temp_min,
    required this.temp_max,
    required this.pressure,
    required this.humidity,
  });
  factory Main.fromJson(Map<String, dynamic> json) => _$MainFromJson(json);

  Map<String, dynamic> toJson() => _$MainToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Wind {
  final double speed;
  final int deg;
  Wind({
    required this.speed,
    required this.deg,
  });
  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);

  Map<String, dynamic> toJson() => _$WindToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Clouds {
  final int all;
  Clouds({
    required this.all,
  });
  factory Clouds.fromJson(Map<String, dynamic> json) => _$CloudsFromJson(json);

  Map<String, dynamic> toJson() => _$CloudsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Sys {
  final String country;
  final int sunrise;
  final int sunset;
  Sys({
    required this.country,
    required this.sunrise,
    required this.sunset,
  });
  factory Sys.fromJson(Map<String, dynamic> json) => _$SysFromJson(json);

  Map<String, dynamic> toJson() => _$SysToJson(this);
}