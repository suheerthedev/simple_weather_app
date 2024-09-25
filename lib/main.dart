import 'package:flutter/material.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Weather App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Montserrat',
          brightness: Brightness.dark,
          appBarTheme: AppBarTheme(
              color: Colors.blue,
              titleTextStyle: Theme.of(context).textTheme.headlineLarge),
          textTheme: const TextTheme(
            headlineLarge: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
            headlineMedium:
                TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )),
      home: const HomeScreen(),
      routes: {
        'splashScreen': (context) => const SplashScreen(),
        'homeScreen': (context) => const HomeScreen(),
      },
    );
  }
}
