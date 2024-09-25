import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/get_weather_api.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController cityCont = TextEditingController();
  WeatherModel? weatherData;

  bool isLoading = false; //for loading indicator

  final String apiKey = '7b3b73136f46fc58b8e6d4e5c15dab50';

  late GetWeatherApi weatherApi;

  @override
  void initState() {
    super.initState();
    weatherApi = GetWeatherApi(apiKey);
  }

  //Function to fetch weather data
  Future<void> fetchWeather() async {
    String cityName = cityCont.text.trim();

    if (cityName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter a city name")));
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      WeatherModel weather = await weatherApi.getWeatherApi(cityName);
      setState(() {
        weatherData = weather; // updated state with fetched weather
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false; // Stop loading if thers an error
      });
      // Handle error (you can show a snackbar or error message)
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed to load weather data :('),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : weatherData != null
                  ? Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(weatherData!.cityName),
                          Text(weatherData!.mainCondition),
                          Text(weatherData!.temperature.toString())
                        ],
                      ),
                    )
                  : const Text("Enter a city to get the weather")),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 300,
            child: TextField(
              controller: cityCont,
              decoration: const InputDecoration(
                  hintText: "Enter City Name",
                  contentPadding: EdgeInsets.symmetric(horizontal: 25)),
            ),
          ),
          // const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: fetchWeather,
            child: const Icon(Iconsax.search_normal),
          ),
        ],
      ),
    );
  }
}
