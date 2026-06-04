import 'package:flutter/material.dart';
import 'package:superheromood/model/hero.dart';
import 'package:superheromood/services/heroapi_connection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class CreateMoodsScreen extends StatefulWidget {
  static const String id = 'createmoods_screen';
  const CreateMoodsScreen({super.key});

  @override
  State<CreateMoodsScreen> createState() => _CreateMoodsScreenState();
}

class _CreateMoodsScreenState extends State<CreateMoodsScreen> {
  String? heroNameToSearch;
  Future<HeroData>? getHeroData;
  String? namaHero;
  String? imgHero;
  int selectedIndex = -1;
  String? moodsText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Card(
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Cari nama hero...',
                  contentPadding: EdgeInsets.all(12),
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  heroNameToSearch = value;
                  if (value.isNotEmpty) {
                    setState(() {
                      getHeroData =
                          HeroApiConnection(heroName: heroNameToSearch!)
                              .getData();
                    });
                  }
                },
              ),
            ),

            // Daftar Hero
            Expanded(
              child: FutureBuilder(
                future: getHeroData,
                builder: (context, AsyncSnapshot<HeroData> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline,
                              size: 48, color: Colors.red),
                          const SizedBox(height: 12),
                          Text(
                            'Gagal memuat data hero.\n${snapshot.error}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasData) {
                    final results = snapshot.data?.results;
                    if (results == null || results.isEmpty) {
                      return const Center(
                        child: Text('Hero tidak ditemukan'),
                      );
                    }
                    return ListView.builder(
                      itemCount: results.length,
                      itemBuilder: ((context, index) {
                        var heroesData = results[index];
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                setState(() {
                                  selectedIndex = index;
                                  namaHero = heroesData.name;
                                  imgHero = heroesData.img;
                                });
                              },
                              child: Card(
                                shape: (selectedIndex == index)
                                    ? RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: Colors.blueAccent, width: 2))
                                    : null,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20.0),
                                  height: 300.0,
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      // Perbaikan: gunakan errorBuilder dan loadingBuilder
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          heroesData.img ?? '',
                                          width: 130,
                                          height: 200,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return SizedBox(
                                              width: 130,
                                              height: 200,
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  value: loadingProgress
                                                              .expectedTotalBytes !=
                                                          null
                                                      ? loadingProgress
                                                              .cumulativeBytesLoaded /
                                                          loadingProgress
                                                              .expectedTotalBytes!
                                                      : null,
                                                ),
                                              ),
                                            );
                                          },
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Container(
                                              width: 130,
                                              height: 200,
                                              color: Colors.grey[300],
                                              child: const Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.broken_image,
                                                      size: 48,
                                                      color: Colors.grey),
                                                  SizedBox(height: 8),
                                                  Text(
                                                    'Gambar\ntidak tersedia',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            heroesData.name ?? '',
                                            style: const TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    );
                  } else {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search, size: 64, color: Colors.grey),
                          SizedBox(height: 12),
                          Text(
                            'Cari hero favoritmu\ndi kolom pencarian di atas',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),

      // Input Moods di bawah
      bottomSheet: Card(
        child: ListTile(
          leading: const Text(
            'Moods',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          title: TextField(
            decoration: const InputDecoration(
              hintText: 'Ketik moods kamu...',
            ),
            onChanged: (value) {
              moodsText = value;
            },
          ),
          trailing: IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              if (namaHero == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Pilih hero terlebih dahulu!'),
                    duration: Duration(seconds: 2),
                  ),
                );
                return;
              }
              final loggedInUser = FirebaseAuth.instance.currentUser;
              if (loggedInUser != null) {
                FirebaseFirestore.instance
                    .collection('moods')
                    .doc(loggedInUser.email)
                    .set({
                  'namahero': namaHero,
                  'urlHero': imgHero,
                  'moodstext': moodsText
                }).then((value) {
                  debugPrint(
                      '${loggedInUser.displayName} berhasil menambahkan moods');
                }).catchError((error) {
                  debugPrint('Gagal menambahkan moods ke database: $error');
                });
              }
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}