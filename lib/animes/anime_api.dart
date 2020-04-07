import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'anime.dart';

class AnimesApi {
  static Future<List<Anime>> getAnimes() async {
//    await Future.delayed(Duration(seconds: 5));

    final url = "https://platy-pus.herokuapp.com/api/animeListFromDB";
//      print("> get: $url");

    final response = await http.get(url);
    String json = response.body;

    // Parser
    final map = convert.json.decode(json);
//      print("< json: $map");

    final mapAnime = map["animes"];

    List<Anime> animes =
        mapAnime.map<Anime>((json) => Anime.fromJson(json)).toList();

    return animes;
  }

  static Future<List<Anime>> getFavoriteAnimes(user) async {
//    await Future.delayed(Duration(seconds: 5));

    final url = "https://platy-pus.herokuapp.com/api/getUser";
//      print("> get: $url");
    var jsonBody = {"id_user": user};
    var headers = {
      "Content-type": "application/json",
      "Secret-One": "Platypus"
    };
    final response = await http.post(url,
        body: convert.json.encode(jsonBody), headers: headers);
    String json = response.body;

    // Parser
    final map = convert.json.decode(json);
//      print("< json: $map");

    final mapAnime = map["animes"];

    List<Anime> animes =
        mapAnime.map<Anime>((json) => Anime.fromJson(json)).toList();

    return animes;
  }
}
