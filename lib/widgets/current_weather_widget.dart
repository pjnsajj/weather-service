import 'package:flutter/material.dart';
import 'package:weather_service/model/weather_data_current.dart';
import 'package:weather_service/model/weather_data_daily.dart';
import 'package:weather_service/utils/custom_colors.dart';

class CurrentWeatherWidget extends StatelessWidget {
  final WeatherDataCurrent weatherDataCurrent;
  final WeatherDataDaily weatherDataDaily;

  const CurrentWeatherWidget(
      {Key? key,
      required this.weatherDataCurrent,
      required this.weatherDataDaily})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        temperatureAreaWidget(),
        maxMinTemperature(),
      ],
    );
  }

  Widget temperatureAreaWidget() {
    return Column(
      children: [
        Image.asset(
          "assets/weather/${weatherDataCurrent.current.weather![0].icon}.png",
          height: 180,
          width: 180,
        ),
        RichText(
          text: TextSpan(children: [
            TextSpan(
                text: '${weatherDataCurrent.current.temp!.toInt()}°',
                style: const TextStyle(
                  color: CustomColors.textColorWhite,
                  fontWeight: FontWeight.w500,
                  fontSize: 64,
                )),
          ]),
        ),
        RichText(
          text: TextSpan(children: [
            TextSpan(
                text: '${weatherDataCurrent.current.weather![0].description}',
                style: const TextStyle(
                  color: CustomColors.textColorWhite,
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                )),
          ]),
        ),
        RichText(
          text: TextSpan(children: [
            TextSpan(
                text: '$weatherDataDaily',
                style: const TextStyle(
                  color: CustomColors.textColorWhite,
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                )),
          ]),
        ),
      ],
    );
  }

  Widget maxMinTemperature() {
    return Container();
  }
}
