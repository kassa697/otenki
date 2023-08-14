import 'package:api_prac/weather.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TopPage extends StatefulWidget {
  const TopPage({super.key});

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  Weather currentWeather = Weather(
    temp: 15,
    description: '晴れ',
    tempMax: 18,
    tempMin: 10,
  );
  List<Weather> hourlyWeather = [
    Weather(temp: 15, description: '晴れ',time: DateTime(2021, 1 ,1 , 10), rainyPercent: 0),
    Weather(temp: 16, description: '雨',time: DateTime(2021, 1 ,1 , 11), rainyPercent: 90),
    Weather(temp: 17, description: '曇り',time: DateTime(2021, 1 ,1 , 12), rainyPercent: 10),
    Weather(temp: 18, description: '晴れ',time: DateTime(2021, 1 ,1 , 13), rainyPercent: 0),    Weather(temp: 15, description: '晴れ',time: DateTime(2021, 1 ,1 , 10), rainyPercent: 0),
    Weather(temp: 16, description: '雨',time: DateTime(2021, 1 ,1 , 11), rainyPercent: 90),
    Weather(temp: 17, description: '曇り',time: DateTime(2021, 1 ,1 , 12), rainyPercent: 10),
    Weather(temp: 18, description: '晴れ',time: DateTime(2021, 1 ,1 , 13), rainyPercent: 0),    Weather(temp: 15, description: '晴れ',time: DateTime(2021, 1 ,1 , 10), rainyPercent: 0),
    Weather(temp: 16, description: '雨',time: DateTime(2021, 1 ,1 , 11), rainyPercent: 90),
    Weather(temp: 17, description: '曇り',time: DateTime(2021, 1 ,1 , 12), rainyPercent: 10),
    Weather(temp: 18, description: '晴れ',time: DateTime(2021, 1 ,1 , 13), rainyPercent: 0),    Weather(temp: 15, description: '晴れ',time: DateTime(2021, 1 ,1 , 10), rainyPercent: 0),
    Weather(temp: 16, description: '雨',time: DateTime(2021, 1 ,1 , 11), rainyPercent: 90),
    Weather(temp: 17, description: '曇り',time: DateTime(2021, 1 ,1 , 12), rainyPercent: 10),
    Weather(temp: 18, description: '晴れ',time: DateTime(2021, 1 ,1 , 13), rainyPercent: 0),
  ];

  List<Weather> dailyWeather = [
    Weather(tempMax: 20, tempMin: 16, rainyPercent: 0, time: DateTime(2021, 1,1)),
    Weather(tempMax: 21, tempMin: 17, rainyPercent: 0, time: DateTime(2021, 1,2)),
    Weather(tempMax: 23, tempMin: 18, rainyPercent: 0, time: DateTime(2021, 1,3)),
  ];

  List<String> weekDay = ['月', '火', '水', '木', '金', '土', '日'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Container(
              width: 200,
              child: TextField(
                onSubmitted: (value) {
                  print(value);
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                hintText: '郵便番号を入力'
              ),)),
          const SizedBox(height: 50,),
          Text(
            '大阪市',
            style: TextStyle(fontSize: 25),
          ),
          Text(currentWeather.description!),
          Text(
            '${currentWeather.temp}°',
            style: TextStyle(fontSize: 60),
          ),
          Row(
            mainAxisAlignment:  MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text('最高：${currentWeather.tempMax}°'),
              ),
              Text('最低：${currentWeather.tempMin}°'),
            ],
          ),
          const SizedBox(height: 50,),
          const Divider(height: 0,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children:
              hourlyWeather.map((weather) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Column(children: [
                    Text('${DateFormat('H').format(weather.time!)}時'),
                    Text('${weather.rainyPercent}%', style: const TextStyle(color:  Colors.blueAccent),),
                    const Icon(Icons.wb_sunny_sharp),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text('${weather.temp}°'),
                    ),
                  ]),
                );
              }).toList(),
            ),
          ),
          const Divider(height: 0,),
          Column(children:
            dailyWeather.map((weather)
            {
              return Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: 50,
                        child: Text('${weekDay[weather.time!.weekday -1]}曜日')),
                    Row(
                      children: [
                        Icon(Icons.wb_sunny_sharp),
                        Text('${weather.rainyPercent}%'),

                      ],
                    ),
                    Container(
                      width: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${weather.tempMax}°'),
                          Text('${weather.tempMin}°'),

                        ],
                      ),
                    ),
                  ],),
              );

            }).toList()
            ,),
        ],
      ),
    ));
  }
}
