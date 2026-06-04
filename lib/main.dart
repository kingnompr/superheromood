import 'package:flutter/material.dart';
import 'package:superheromood/screens/main_screen.dart';
import 'package:superheromood/screens/createmoods_screen.dart';
import 'package:superheromood/screens/userdisplayname_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:superheromood/screens/login_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Superhero Mood',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id: (context) => const LoginScreen(),
        MainScreen.id: (context) => const MainScreen(),
        CreateMoodsScreen.id: (context) => const CreateMoodsScreen(),
        // Route untuk UserDisplayNameScreen (Bagian 5 - Challenge)
        UserDisplayNameScreen.id: (context) => const UserDisplayNameScreen(),
      },
    );
  }
}
