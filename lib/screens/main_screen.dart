import 'package:flutter/material.dart';
import 'package:superheromood/screens/createmoods_screen.dart';
import 'package:superheromood/screens/userdisplayname_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:superheromood/screens/login_screen.dart';
class MainScreen extends StatefulWidget {
  static const String id = 'main_screen';
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;
  
  String imgProfile =
      'https://www.its.ac.id/aktuaria/wp-content/uploads/sites/100/2018/03/user.png';
  dynamic myDisplayName = 'User';
  String namaHero = 'superheroname';
  String moodsHero = '.....';

  final _firebaseFirestore = FirebaseFirestore.instance.collection('moods');

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    streamFirestoreData();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        myDisplayName = loggedInUser?.displayName ?? 'User';
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void streamFirestoreData() {
    if (loggedInUser?.email != null) {
      _firebaseFirestore.doc(loggedInUser!.email).snapshots().listen((event) {
        if (event.data() != null) {
          setState(() {
            namaHero = event.data()?['namahero'] ?? namaHero;
            imgProfile = event.data()?['urlHero'] ?? imgProfile;
            moodsHero = event.data()?['moodstext'] ?? moodsHero;
          });
        }
      });
    }
  }

  void deleteMoods() async {
    if (loggedInUser?.email != null) {
      await _firebaseFirestore.doc(loggedInUser!.email).delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
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
                    onBackgroundImageError: (exception, stackTrace) {
                      // handle error gambar profil
                    },
                    child: imgProfile.isEmpty
                        ? const Icon(Icons.person, size: 80)
                        : null,
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
                  ElevatedButton(
                    onPressed: () {
                      deleteMoods();
                      setState(() {
                        imgProfile = 'https://www.its.ac.id/aktuaria/wp-content/uploads/sites/100/2018/03/user.png';
                        namaHero = 'superheroname';
                        moodsHero = '.....';
                      });
                    },
                    child: const Text('Delete moods'),
                  ),
                  const SizedBox(height: 20.0),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Tombol Settings - navigasi ke UserDisplayNameScreen (Bagian 5)
                        IconButton(
                          iconSize: 35.0,
                          tooltip: 'Set Profile Name',
                          icon: const Icon(Icons.settings),
                          onPressed: () {
                            Navigator.pushNamed(
                                    context, UserDisplayNameScreen.id)
                                .whenComplete(
                              () => setState(() {
                                // Refresh state setelah kembali dari UserDisplayNameScreen
                              }),
                            );
                          },
                        ),
                        // Tombol Create Moods - navigasi ke CreateMoodsScreen
                        IconButton(
                          iconSize: 35.0,
                          tooltip: 'Create Moods',
                          icon: const Icon(Icons.person_add),
                          onPressed: () {
                            Navigator.pushNamed(context, CreateMoodsScreen.id)
                                .whenComplete(
                              () => setState(() {}),
                            );
                          },
                        ),
                        // Tombol Log Out (Bagian 4)
                        IconButton(
                          iconSize: 35.0,
                          tooltip: 'Log Out',
                          icon: const Icon(Icons.power_settings_new),
                          onPressed: () {
                            // fungsi logout (Bagian 4 - Firebase Auth)
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Log Out'),
                                content:
                                    const Text('Yakin ingin keluar?'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context),
                                    child: const Text('Batal'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      _auth.signOut();
                                      Navigator.pushReplacementNamed(context, LoginScreen.id);
                                    },
                                    child: const Text('Ya, Keluar'),
                                  ),
                                ],
                              ),
                            );
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