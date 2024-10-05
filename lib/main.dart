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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      title: "Weather App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Montserrat',
          brightness: Brightness.dark,
          appBarTheme: AppBarTheme(
              color: Colors.blue,
              titleTextStyle: Theme.of(context).textTheme.headlineLarge),
          textTheme: TextTheme(
            headlineLarge: TextStyle(fontSize: screenWidth * 0.07, fontWeight: FontWeight.bold),
            headlineMedium:
                TextStyle(fontSize: screenWidth * 0.06, fontWeight: FontWeight.bold),
            headlineSmall: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold),
          )),
      home: const SplashScreen(),
      routes: {
        '/splashScreen': (context) => const SplashScreen(),
        '/homeScreen': (context) => const HomeScreen(),
      },
    );
  }
}
