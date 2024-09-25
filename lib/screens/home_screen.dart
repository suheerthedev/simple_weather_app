import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController cityCont = TextEditingController();
  @override
  void initState() {
    super.initState();
    // fetch weather on startup
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("City Name"),
            Text("Weather Animation"),
            Text("Temperature")
          ],
        ),
      ),
      floatingActionButton: Row(
        children: [
          TextField(
            controller: cityCont,
            decoration: const InputDecoration(hintText: "Enter City Name"),
          ),
          FloatingActionButton(onPressed: () {}),
        ],
      ),
    );
  }
}
