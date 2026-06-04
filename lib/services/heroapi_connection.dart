import 'dart:convert';
import 'package:superheromood/model/hero.dart';
import 'package:http/http.dart' as http;

class HeroApiConnection {
  String heroName;

  HeroApiConnection({required this.heroName});

  Future<HeroData> getData() async {
    http.Response response = await http.get(
      Uri.parse(
        'https://superheroapi.com/api.php/18845b86db16d9c704af3b6be6361bb7/search/$heroName',
      ),
    );

    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      HeroData heroData = HeroData.fromJson(json as Map<String, dynamic>);
      return heroData;
    } else {
      throw Exception('Failed to load HeroData');
    }
  }
}