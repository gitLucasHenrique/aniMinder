import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:animinder/animes/anime.dart';
import 'package:animinder/animes/anime_api.dart';
import 'package:animinder/widget/animeBackground.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FollowingPage extends StatefulWidget {
  const FollowingPage();
  _FollowingPageState createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage> {
  Widget build(BuildContext context) {
    final FirebaseMessaging _messaging = FirebaseMessaging();

    return FutureBuilder(
      future: _messaging.getToken(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.orange,
            ),
          );
        }
        //List<Anime> animes = snapshot.data;
        Future<List<Anime>> animes = AnimesApi.getFavoriteAnimes(snapshot.data);
        final tk = snapshot.data;
        return FutureBuilder(
            future: animes,
            builder: (context, results) {
              if (!results.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.orange,
                  ),
                );
              }
              List<Anime> animesResult = results.data;
              return Stack(
                children: <Widget>[
                  AnimeBackground(),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: animesResult.length > 0
                        ? ListView.builder(
                            itemCount: animesResult.length,
                            itemBuilder: (context, idx) {
                              return _favListBuilder(context, animesResult[idx],
                                  tk, animesResult, idx);
                            })
                        : _noFavFound(),
                  )
                ],
              );
            });
      },
    );
  }

  _noFavFound() {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.sentiment_very_dissatisfied,
              size: 300,
              color: Colors.black87,
            ),
            Text(
              "NANI ?!?!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "No animes found..",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }

  _favListBuilder(context, paramAnime, tk, paramAnimesResult, idx) {
    Anime anime = paramAnime;
    List<Anime> animes = paramAnimesResult;
    return Container(
      padding: EdgeInsets.fromLTRB(20, 2, 20, 20),
      child: Dismissible(
        key: Key(anime.name + "a"),
        onDismissed: (direction) {
          _removerAnime(anime, tk, animes, idx);
        },
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 30,
              child: Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ),
                  child: anime.img.isNotEmpty
                      ? Image.network(
                          anime.img,
                          fit: BoxFit.cover,
                        )
                      : Icon(
                          Icons.error,
                          color: Colors.red,
                          size: 50,
                        ),
                ),
              ),
            ),
            Expanded(
              flex: 60,
              child: Container(
                height: 100,
                padding: EdgeInsets.symmetric(horizontal: 20),
                color: Colors.white70,
                width: double.infinity,
                child: Center(
                  child: Text(
                    anime.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 15,
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  color: checkColor(anime.dayOTW),
                ),
                width: double.infinity,
                child: RotatedBox(
                  quarterTurns: 1,
                  child: Center(
                    child: Text(
                      anime.checkDayOTW(anime.dayOTW),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _removerAnime(anime, token, animes, idx) {
    var jsonBody = {
      "id_user": token,
      "anime": {"name": anime.name, "dayOTW": anime.dayOTW, "img": anime.img}
    };
    //print(json.encode(jsonBody));
    Map<String, String> headers = {"Content-Type": "application/json"};
    http
        .post("https://platy-pus.herokuapp.com/api/addAnime",
            body: json.encode(jsonBody), headers: headers)
        .then(
          (response) => setState(
            () {
              animes.removeAt(idx);
              print("remved " + anime.name);
            },
          ),
        );
  }
}

checkColor(int dayOTW) {
  switch (dayOTW) {
    case 1:
      return Colors.red;
      break;
    case 2:
      return Colors.orange;
      break;
    case 3:
      return Colors.yellow;
      break;
    case 4:
      return Colors.green;
      break;
    case 5:
      return Colors.lightBlueAccent;
      break;
    case 6:
      return Colors.blue;
      break;
    case 0:
      return Colors.purple;
      break;
    default:
      return Colors.black54;
  }
}
