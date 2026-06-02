import 'package:flutter/material.dart';
import 'package:superheromood/screens/createmoods_screen.dart';

class MainScreen extends StatefulWidget {
  static const String id = 'main_screen';
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String imgProfile =
      'https://www.its.ac.id/aktuaria/wp-content/uploads/sites/100/2018/03/user.png';
  dynamic myDisplayName = 'User';
  String namaHero = 'superheroname';
  String moodsHero = '.....';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(imgProfile),
                    radius: 80.0,
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'Helo $myDisplayName, you are $namaHero!',
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'Moods: $moodsHero',
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                          iconSize: 35.0,
                          tooltip: 'Set Profile Name',
                          icon: const Icon(Icons.settings),
                          onPressed: () {
                            // navigasi ke userdisplayname_screen (Bagian 5)
                          },
                        ),
                        IconButton(
                          iconSize: 35.0,
                          tooltip: 'Create Moods',
                          icon: const Icon(Icons.person_add),
                          onPressed: () {
                            Navigator.pushNamed(context, CreateMoodsScreen.id);
                          },
                        ),
                        IconButton(
                          iconSize: 35.0,
                          tooltip: 'Log Out',
                          icon: const Icon(Icons.power_settings_new),
                          onPressed: () {
                            // fungsi logout (Bagian 4)
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}