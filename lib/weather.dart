import 'dart:convert';

import 'package:http/http.dart';

class Weather {
  late final temp;
  int? tempMax;
  int? tempMin;
  String? description;
  double? lon;
  double? lat;
  String? icon;
  DateTime? time;
  int? rainyPercent;

  Weather({
    this.temp,
    this.tempMax,
    this.tempMin,
    this.description,
    this.lon,
    this.lat,
    this.icon,
    this.time,
    this.rainyPercent,
  });

  static Future<Weather> getWeather (String zipCode) async {
    String zipCode0;
    if (zipCode.contains('-')) {
      zipCode0 = zipCode;
    } else {
      zipCode0 = '${zipCode.substring(0, 3)}-${zipCode.substring(3)}';
    }
    String url = 'https://api.openweathermap.org/data/2.5/weather?zip=$zipCode0,jp&appid=8c9d10cca7b5449bd9d22b42cb511deb&lang=ja&units=metric';
    try {
      var result = await get(Uri.parse(url));
      Map<String, dynamic> data = jsonDecode(result.body);
      // print(data['weather'][0]['description']);
      Weather currentWeather = Weather(
        description: data['weather'][0]['description'],
        temp: data['main']['temp'].toInt(),
        tempMax: data['main']['temp_max'].toInt(),
        tempMin: data['main']['temp_min'].toInt(),
        lat: data['coord']['lat'],
        lon: data['coord']['lon'],
      );
      // print(currentWeather);
      return currentWeather;
    } catch (e) {
      print(
        '''err
        ----------
          $e
          ----------
      '''
      );
      return Weather();
    }
  }
  static Future<List<Weather?>> getDayWeather ({required double lon, required double lat}) async {
    String url = 'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=8c9d10cca7b5449bd9d22b42cb511deb&units=metric&lang=ja';
  try {
    final result = await get(Uri.parse(url));
    Map<String, dynamic> data = jsonDecode(result.body);
    // print(data['list'][0]['weather'][0]['description']);
    // print(data['list']);
    List<dynamic> dayWeatherData = data['list'];
    List<Weather?> dayWeather = dayWeatherData.map((weather) {
      return Weather(
        time: DateTime.fromMillisecondsSinceEpoch(weather['dt'] * 1000),
        temp: weather['main']['temp'].toInt(),
        icon: weather['weather'][0]['icon'],
        tempMax: weather['main']['temp_max'].toInt(),
        tempMin: weather['main']['temp_max'].toInt(),
      );
    }).toList();
    print(dayWeather[1]?.time);
    print(dayWeather[1]?.temp);
    print(dayWeather[1]?.icon);
    return dayWeather;
  } catch (e) {
    print('err?');
    print((e));
  return [Weather()];
  }

  }
}
