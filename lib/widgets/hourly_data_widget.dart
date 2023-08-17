import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:weather_service/controller/global_controller.dart';
import 'package:weather_service/model/weather_data_hourly.dart';
import 'package:weather_service/utils/custom_colors.dart';

class HourlyDataWwidget extends StatefulWidget {
  final WeatherDataHourly weatherDataHourly;
  const HourlyDataWwidget({Key? key, required this.weatherDataHourly})
      : super(key: key);

  @override
  State<HourlyDataWwidget> createState() => _HourlyDataWwidgetState();
}

class _HourlyDataWwidgetState extends State<HourlyDataWwidget> {
  RxInt cardIndex = GlobalController().getIndex();

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    String formatter = DateFormat('d MMMM').format(now);
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 24, right: 24, top: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.2),
          border: Border.all(
            color: Colors.black54,
          ),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text(
              'Сегодня',
              style: TextStyle(
                fontSize: 17,
                color: CustomColors.textColorWhite,
              ),
            ),
            Text(
              formatter,
              style:
                  const TextStyle(fontSize: 17, color: CustomColors.textColorWhite),
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
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.weatherDataHourly.hourly.length > 12
            ? 14
            : widget.weatherDataHourly.hourly.length,
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
                            offset: const Offset(0.5, 0),
                            blurRadius: 30,
                            spreadRadius: 1,
                            color: const Color.fromARGB(255, 255, 255, 255)
                                .withOpacity(0))
                      ],
                      gradient: cardIndex.value == index
                          ? const LinearGradient(colors: [
                              CustomColors.firstGradientColor,
                              CustomColors.secondGradientColor
                            ])
                          : null),
                  child: HourlyDetails(
                    temp: widget.weatherDataHourly.hourly[index].temp!,
                    index: index,
                    cardIndex: cardIndex.toInt(),
                    timeStamp: widget.weatherDataHourly.hourly[index].dt!,
                    weatherIcon:
                        widget.weatherDataHourly.hourly[index].weather![0].icon!,
                  ),
                ),
              )));
        },
      ),
    );
  }
}

class HourlyDetails extends StatefulWidget {
  int temp;
  int index;
  int cardIndex;
  int timeStamp;
  String weatherIcon;

  HourlyDetails(
      {Key? key,
      required this.temp,
      required this.index,
      required this.cardIndex,
      required this.timeStamp,
      required this.weatherIcon})
      : super(key: key);

  @override
  State<HourlyDetails> createState() => _HourlyDetailsState();
}

class _HourlyDetailsState extends State<HourlyDetails> {
  String getTime(final timeStamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String x = DateFormat('Hm').format(time);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            getTime(widget.timeStamp),
            style: const TextStyle(color: CustomColors.textColorWhite, fontSize: 15),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child: Image.asset(
            'assets/weather/${widget.weatherIcon}.png',
            height: 40,
            width: 40,
          ),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child: Text(
            '${widget.temp}°',
            style: const TextStyle(color: CustomColors.textColorWhite, fontSize: 17),
          ),
        )
      ],
    );
  }
}
