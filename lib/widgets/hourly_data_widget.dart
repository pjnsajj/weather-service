import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:weather_service/controller/global_controller.dart';
import 'package:weather_service/model/weather_data_hourly.dart';
import 'package:weather_service/utils/custom_colors.dart';

class HourlyDataWwidget extends StatelessWidget {
  final WeatherDataHourly weatherDataHourly;
  HourlyDataWwidget({Key? key, required this.weatherDataHourly})
      : super(key: key);

  RxInt cardIndex = GlobalController().getIndex();

  @override
  Widget build(BuildContext context) {
    final now = new DateTime.now();
    String formatter = DateFormat('d MMMM').format(now);
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 24, right: 24, top: 24),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.2),
          border: new Border.all(
            color: Colors.black54,
          ),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              'Сегодня',
              style: TextStyle(
                fontSize: 17,
                color: CustomColors.textColorWhite,
              ),
            ),
            Text(
              formatter,
              style:
                  TextStyle(fontSize: 17, color: CustomColors.textColorWhite),
            ),
          ]),
          hourlyList(),
        ],
      ),
    );
  }

  Widget hourlyList() {
    return Container(
      height: 200,
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weatherDataHourly.hourly.length > 12
            ? 14
            : weatherDataHourly.hourly.length,
        itemBuilder: (context, index) {
          return Obx((() => GestureDetector(
                onTap: () {
                  cardIndex.value = index;
                },
                child: Container(
                  width: 90,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0.5, 0),
                            blurRadius: 30,
                            spreadRadius: 1,
                            color: Color.fromARGB(255, 255, 255, 255)
                                .withOpacity(0))
                      ],
                      gradient: cardIndex.value == index
                          ? const LinearGradient(colors: [
                              CustomColors.firstGradientColor,
                              CustomColors.secondGradientColor
                            ])
                          : null),
                  child: HourlyDetails(
                    temp: weatherDataHourly.hourly[index].temp!,
                    index: index,
                    cardIndex: cardIndex.toInt(),
                    timeStamp: weatherDataHourly.hourly[index].dt!,
                    weatherIcon:
                        weatherDataHourly.hourly[index].weather![0].icon!,
                  ),
                ),
              )));
        },
      ),
    );
  }
}

class HourlyDetails extends StatelessWidget {
  int temp;
  int index;
  int cardIndex;
  int timeStamp;
  String weatherIcon;

  String getTime(final timeStamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String x = DateFormat('Hm').format(time);
    return x;
  }

  HourlyDetails(
      {Key? key,
      required this.temp,
      required this.index,
      required this.cardIndex,
      required this.timeStamp,
      required this.weatherIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(
            getTime(timeStamp),
            style: TextStyle(color: CustomColors.textColorWhite, fontSize: 15),
          ),
        ),
        Container(
          margin: EdgeInsets.all(5),
          child: Image.asset(
            'assets/weather/$weatherIcon.png',
            height: 40,
            width: 40,
          ),
        ),
        Container(
          margin: EdgeInsets.all(5),
          child: Text(
            '$temp°',
            style: TextStyle(color: CustomColors.textColorWhite, fontSize: 17),
          ),
        )
      ],
    );
  }
}
