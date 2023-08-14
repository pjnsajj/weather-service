import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:weather_service/firebase_options.dart';
import 'package:weather_service/screens/auth/reset_screen.dart';
import 'package:weather_service/screens/auth/sigup_screen.dart';
import 'package:weather_service/screens/home_screen.dart';
import 'package:weather_service/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      routes: {
        '/home': (context) => const HomeScreen(),
        'splash': (context) => SplashScreen(),
        '/signup': (context) => SignUpScreen(),
        '/reset_password': (context) => ResetPasswordScreen(),
      },
      initialRoute: 'splash',
      title: 'Weather',
      debugShowCheckedModeBanner: false,
    );
  }
}
