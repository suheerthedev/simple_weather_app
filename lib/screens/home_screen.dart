import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/get_weather_api.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
    cityCont.clear();

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

  //weather animation
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/animations/atmosphere.json';

    switch (mainCondition.toLowerCase()) {
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
      case 'sand':
      case 'ash':
      case 'squall':
      case 'tornado':
        return 'assets/animations/atmosphere.json';
      case 'clouds':
        return 'assets/animations/clouds.json';
      case 'drizzle':
        return 'assets/animations/drizzle.json';
      case 'rain':
      case 'shower rain':
        return 'assets/animations/rain.json';
      case 'snow':
        return 'assets/animations/snow.json';
      case 'sunny':
        return 'assets/animations/sunny.json';
      case 'clear':
        return 'assets/animations/sunny.json';
      case 'thunderstorm':
        return 'assets/animations/thunder.json';
      default:
        return 'assets/animations/sunny.json';
    }
  }

  @override
  Widget build(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: isLoading
                ? const CircularProgressIndicator()
                : weatherData != null
                    ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: screenHeight * 0.02),
                         Icon(Icons.location_on, size: screenWidth * 0.05),
                        Text(weatherData!.cityName,
                            style:
                                Theme.of(context).textTheme.headlineLarge),
                                                    SizedBox(height: screenHeight * 0.02),
                        Lottie.asset(getWeatherAnimation(
                            weatherData!.mainCondition), width: screenWidth*0.6),
                        Text(weatherData!.mainCondition,
                            style:
                                Theme.of(context).textTheme.headlineSmall),
                        const SizedBox(height: 5),
                        Text("${weatherData!.temperature.toString()} °C",
                            style:
                                Theme.of(context).textTheme.headlineMedium),
                                                    SizedBox(height: screenHeight * 0.1),
                      ],
                    )
                    :  Text(
                        "Enter a country/state/city to get the weather",
                        style: TextStyle(fontSize: screenWidth * 0.04),)),
      ),
      floatingActionButton: Padding(
        padding:  EdgeInsets.only(left: screenWidth * 0.05),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: screenWidth * 0.8,
              child: TextField(
                controller: cityCont,
                decoration: InputDecoration(
                    hintText: "Enter Location (City, State, or Country)",
                    hintStyle:  TextStyle(
                        fontSize: screenWidth * 0.035,
                        fontWeight: FontWeight.normal,
                        color: Colors.white54),
                    contentPadding:  EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white))),
              ),
            ),
             SizedBox(width: screenWidth * 0.02),
            SizedBox.square(
              dimension: screenWidth * 0.12,
              child: FloatingActionButton(
                onPressed: fetchWeather,
                backgroundColor: Colors.white,
                child: const Icon(
                  Iconsax.search_normal_copy,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
