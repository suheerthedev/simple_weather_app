import 'package:flutter/material.dart';
import 'package:weather_app/screens/home_screen.dart';

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
              headlineLarge:
                  TextStyle(fontSize: 36, fontWeight: FontWeight.bold))),
      home: const HomeScreen(title: 'Weather App'),
    );
  }
}
