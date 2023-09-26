import 'package:api_prac/weather.dart';
import 'package:api_prac/zip_code.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TopPage extends StatefulWidget {
  const TopPage({super.key});

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  Weather currentWeather = Weather();
  String address = '-';
  String errorMessage = '';
  List<Weather?> threeHourWeather = [];

  List<Weather?> dailyWeather = [];

  List<String> weekDay = ['月', '火', '水', '木', '金', '土', '日'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                width: 200,
                child: TextField(
                  onSubmitted: (value) async {
                    Map<String, String> response = {};
                    response = await ZipCpde.searchAddress(zipCode: value);
                    // print(wes);
                    if (response['message'] == null) {
                      errorMessage = '';
                    } else {
                      print('koko');
                      errorMessage = response['message']!;
                    }
                    if (response.containsKey('address')) {
                      address = response['address']!;
                      currentWeather = await Weather.getWeather(value);
                      threeHourWeather = await Weather.getDayWeather(lon: currentWeather.lon ?? 0.0, lat: currentWeather.lat ?? 0.0);
                      dailyWeather = await Weather.getDayWeather(lon: currentWeather.lon ?? 0.0, lat: currentWeather.lat ?? 0.0);
                    }
                    setState(() {});
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: '郵便番号を入力'),
                )),
            Text(errorMessage ?? '', style: const TextStyle(color: Colors.redAccent),),
            const SizedBox(
              height: 50,
            ),
            Text(
              address,
              style: TextStyle(fontSize: 25),
            ),
            Text(currentWeather.description ?? 'no data'),

            Text(
              '${currentWeather?.temp ?? 0}°',
              style: TextStyle(fontSize: 60),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text('最高：${currentWeather?.tempMax}°'),
                ),
                Text('最低：${currentWeather?.tempMin ?? 0}°'),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            const Divider(
              height: 0,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: threeHourWeather == null ? Container() : Row(
                children: threeHourWeather.map((weather) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Column(children: [
                      Text('${DateFormat('H').format(weather!.time!)}時'),
                      Image.network('https://openweathermap.org/img/wn/${weather.icon}.png'),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text('${weather.temp}°'),
                      ),
                    ]),
                  );
                }).toList(),
              ),
            ),
            const Divider(
              height: 0,
            ),
            dailyWeather == null ? Container() : Column(
              children: dailyWeather.map((weather) {
                return Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: 50,
                          child: Text('${weekDay[weather!.time!.weekday - 1]}曜日')),
                      Row(
                        children: [
                          Image.network('https://openweathermap.org/img/wn/${weather!.icon}.png'),
                        ],
                      ),
                      Container(
                        width: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${weather!.tempMax}°'),
                            Text('${weather.tempMin}°'),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    ));
  }
}
