import 'dart:convert';
import 'dart:io';
import 'dart:async';

List data = [];
bool firstimeapi = true;
bool trovat = true;

class Digimon {
  final String name;

  String? apiname;
  String? levelDigimon;
  String? imageUrl;
  int id = 0;

  int rating = 10;

  Digimon(this.name);

  Future getImageUrl() async {
    trovat = false;
    if (imageUrl != null) {
      return;
    }

    try {
      apiname = name.toLowerCase();
      if (firstimeapi) {
        HttpClient http = new HttpClient();
        var uri = new Uri.https('thronesapi.com', '/api/v2/Characters');
        var request = await http.getUrl(uri);
        var response = await request.close();
        var responseBody = await response.transform(utf8.decoder).join();
        data = json.decode(responseBody);
        firstimeapi = false;
      }
      for (var i = 0; i < data.length && !trovat; i++) {
        var comparer = data[i]["fullName"];
        comparer = comparer.toString().toLowerCase();
        if (apiname == comparer) {
          id = i;
          trovat = true;
        }
      }
      trovat = false;
      imageUrl = data[id]["imageUrl"];
      levelDigimon = data[id]["title"];

      print(levelDigimon);
    } catch (exception) {
      print(exception);
    }
  }
}
