import 'package:flutter/material.dart';
import 'package:superheromood/model/hero.dart';
import 'package:superheromood/services/heroapi_connection.dart';

class CreateMoodsScreen extends StatefulWidget {
  static const String id = 'createmoods_screen';
  const CreateMoodsScreen({super.key});

  @override
  State<CreateMoodsScreen> createState() => _CreateMoodsScreenState();
}

class _CreateMoodsScreenState extends State<CreateMoodsScreen> {
  String? heroNameToSearch;
  var getHeroData;
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
                ),
                onChanged: (value) {
                  heroNameToSearch = value;
                  setState(() {
                    getHeroData =
                        HeroApiConnection(heroName: heroNameToSearch!)
                            .getData();
                  });
                },
              ),
            ),

            // Daftar Hero
            Expanded(
              child: FutureBuilder(
                future: getHeroData,
                builder: (context, AsyncSnapshot<HeroData> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data?.results?.length,
                      itemBuilder: ((context, index) {
                        var heroesData = snapshot.data!.results![index];
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
                                            color: Colors.blueAccent))
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
                                      Image.network(heroesData.img ?? ''),
                                      Text(
                                        heroesData.name ?? '',
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w700,
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
                      child: Text('Search your hero first'),
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
            onChanged: (value) {
              moodsText = value;
            },
          ),
          trailing: IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              // Bagian 4: kirim ke Firebase
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}