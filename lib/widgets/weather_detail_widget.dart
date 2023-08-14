import 'package:flutter/material.dart';
import 'package:weather_service/model/weather_data_current.dart';
import 'package:weather_service/utils/custom_colors.dart';

class WeatherDetailWidget extends StatelessWidget {
  final WeatherDataCurrent weatherDataCurrent;
  const WeatherDetailWidget({Key? key, required this.weatherDataCurrent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String getWindDirectionText(double windDeg) {
      if (windDeg >= 0 && windDeg < 22.5) {
        return 'Северный';
      } else if (windDeg >= 22.5 && windDeg < 67.5) {
        return 'Северо-восточный';
      } else if (windDeg >= 67.5 && windDeg < 112.5) {
        return 'Восточный';
      } else if (windDeg >= 112.5 && windDeg < 157.5) {
        return 'Юго-восточный';
      } else if (windDeg >= 157.5 && windDeg < 202.5) {
        return 'Южный';
      } else if (windDeg >= 202.5 && windDeg < 247.5) {
        return 'Юго-западный';
      } else if (windDeg >= 247.5 && windDeg < 292.5) {
        return 'Западный';
      } else if (windDeg >= 292.5 && windDeg < 337.5) {
        return 'Северо-западный';
      } else {
        return 'Северный';
      }
    }

    String windDirectionText =
        getWindDirectionText(weatherDataCurrent.current.windDeg!.toDouble());

    String getHumidityStatus(int humidity) {
      if (humidity > 70) {
        return 'Высокая влажность';
      } else if (humidity > 50) {
        return 'Нормальная влажность';
      } else {
        return 'Низкая влажность';
      }
    }

    String humidityStatus =
        getHumidityStatus(weatherDataCurrent.current.humidity!);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23),
      child: Container(
        padding: EdgeInsets.only(right: 16, left: 16),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.2),
          border: new Border.all(
            color: Colors.black54,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  padding: EdgeInsets.all(16),
                  child: Image.asset('assets/icons/windspeed.png'),
                ),
                Text(
                  '${weatherDataCurrent.current.windSpeed}м/с',
                  style: TextStyle(
                    fontSize: 15,
                    color: CustomColors.textColorWhite,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 34),
                  child: Text(
                    windDirectionText,
                    style: TextStyle(
                      fontSize: 15,
                      color: CustomColors.textColorWhite,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  padding: EdgeInsets.all(16),
                  child: Image.asset('assets/icons/humidity.png'),
                ),
                Text(
                  '${weatherDataCurrent.current.humidity}%',
                  style: TextStyle(
                    fontSize: 15,
                    color: CustomColors.textColorWhite,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 60),
                  child: Text(
                    humidityStatus,
                    style: TextStyle(
                      fontSize: 15,
                      color: CustomColors.textColorWhite,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
