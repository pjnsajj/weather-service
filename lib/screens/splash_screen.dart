import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_service/screens/auth/login_screen.dart';

import 'package:weather_service/utils/custom_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
      );
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Color.fromARGB(255, 12, 4, 225),
            Color.fromARGB(255, 0, 0, 0)
          ])),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'WEATHER',
            style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 48,
              fontWeight: FontWeight.w700,
              color: CustomColors.textColorWhite,
            ),
          ),
          Text(
            'SERVICE',
            style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 48,
              fontWeight: FontWeight.w700,
              color: CustomColors.textColorWhite,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 300, bottom: 100),
            child: Text(
              'dawn is coming soon',
              style: TextStyle(
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w300,
                  fontSize: 24,
                  color: CustomColors.textColorWhite),
            ),
          )
        ],
      ),
    );
  }
}
