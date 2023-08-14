import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_service/controller/global_controller.dart';
import 'package:weather_service/screens/account_screen.dart';
import 'package:weather_service/screens/auth/login_screen.dart';
import 'package:weather_service/widgets/current_weather_widget.dart';
import 'package:weather_service/widgets/header_widget.dart';
import 'package:weather_service/widgets/hourly_data_widget.dart';
import 'package:weather_service/widgets/weather_detail_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromARGB(255, 12, 4, 225),
              Color.fromARGB(255, 0, 0, 0)
            ])),
        child: SafeArea(
          child: Obx(() => globalController.checkLoading().isTrue
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const HeaderWidget(),
                          IconButton(
                            onPressed: () {
                              if ((user == null)) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AccountScreen()),
                                );
                              }
                            },
                            icon: Icon(
                              Icons.person,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      CurrentWeatherWidget(
                        weatherDataDaily:
                            globalController.getData().getDailyWeather(),
                        weatherDataCurrent:
                            globalController.getData().getCurrentWeather(),
                      ),
                      HourlyDataWwidget(
                        weatherDataHourly:
                            globalController.getData().getHourlyWeather(),
                      ),
                      SizedBox(height: 20),
                      WeatherDetailWidget(
                        weatherDataCurrent:
                            globalController.getData().getCurrentWeather(),
                      ),
                    ],
                  ),
                )),
        ),
      ),
    );
  }
}
