import 'package:flutter/material.dart';
import 'package:superheromood/screens/main_screen.dart';
import 'package:superheromood/screens/createmoods_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Superhero Mood',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: MainScreen.id,
      routes: {
        MainScreen.id: (context) => const MainScreen(),
        CreateMoodsScreen.id: (context) => const CreateMoodsScreen(),
      },
    );
  }
}