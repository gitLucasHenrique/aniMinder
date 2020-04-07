import 'dart:ui';
import 'package:animinder/animes/anime.dart';
import 'package:animinder/pages/anime_details.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;

class AnimesGridView extends StatelessWidget {
  final List<Anime> animes;
  final FirebaseMessaging userToken;
  const AnimesGridView(this.animes, this.userToken);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: animes.length,
        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
        itemBuilder: (context, idx) {
          return _gridBuilder(context, animes[idx], userToken);
        });
  }

  _gridBuilder(context, paramAnime, paramUserToken) {
    Anime anime = paramAnime;
    FirebaseMessaging token = paramUserToken;
    return Container(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AnimeDetails(anime: anime, token: token),
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 8,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.orange[600],
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54.withOpacity(0.9),
                      blurRadius: 10.0,
                    )
                  ],
                ),
                child: Hero(
                  tag: anime.img,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: anime.img,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.orangeAccent),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.orange[600].withOpacity(0.4),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepOrangeAccent.withOpacity(0.9),
                      blurRadius: 10.0,
                    )
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Center(
                    child: Text(
                      anime.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.orange[50],
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
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

  Future<void> sendPost(userToken, message, device) async {
    http.post(
        Uri.encodeFull(
            'https://push-cron-test.us-south.cf.appdomain.cloud/sendPush'),
        headers: {
          "Accept": "application/json"
        },
        body: {
          "user": userToken,
          "message": message,
          "deviceType": device
        }).then((res) => print("aaaaa"));
    print("object");
  }

  Future<void> sendPostFollowAnime(animeName, animeId) async {
    String jsonBody =
        '{"db_name": "animes", "id_doc": "animesList", "animes": [{ "name": "$animeName", "id": "$animeId" }] }';
    print(jsonBody);
    http
        .put(
            Uri.encodeFull(
                'https://push-cron-test.us-south.cf.appdomain.cloud/teste'),
            headers: {
              "Content-type": "application/json",
              "Secret-One": "Platypus"
            },
            body: jsonBody)
        .then((response) => response);
  }
}
