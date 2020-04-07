import 'dart:convert';
import 'dart:ui';

import 'package:animinder/animes/anime.dart';
import 'package:animinder/animes/anime_api.dart';
import 'package:animinder/pages/following_page.dart';
import 'package:animinder/widget/animeBackground.dart';
import 'package:animinder/widget/animeGridView.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'package:http/http.dart' as http;

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  TabController controller;
  final FirebaseMessaging _messaging = FirebaseMessaging();
  @override
  void initState() {
    (Platform.isAndroid) ? print("ANDROID") : print("IOS");

    _messaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, alert: true, badge: true));
    controller = TabController(vsync: this, length: 2);

    super.initState();
    _messaging.getToken().then((token) {
      createUserDB(token, (Platform.isAndroid) ? "ANDROID" : "IOS");
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String t;
    return Scaffold(
      /*
      appBar: AppBar(
        centerTitle: true,
        title: Text("aniMinder"),
        backgroundColor: Colors.orange[600],
      ),*/
      bottomNavigationBar: Material(
        color: Colors.orange[600],
        child: TabBar(
          unselectedLabelColor: Colors.orangeAccent.withOpacity(0.9),
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: Colors.orangeAccent,
          indicator: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          controller: controller,
          tabs: <Widget>[
            Tab(
              //icon: Icon(Icons.ondemand_video),
              text: "     Animes     ",
            ),
            Tab(
              //icon: Icon(Icons.event_note),
              text: "   Remind Me!   ",
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.deepOrange,
        child: SafeArea(
          child: Container(
            color: Colors.grey[200],
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.orange[600],
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "aniMinder",
                      style: TextStyle(
                        color: Colors.orange[50],
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 20,
                  child: TabBarView(
                    controller: controller,
                    children: <Widget>[
                      Container(
                        child: Stack(
                          children: <Widget>[
                            AnimeBackground(),
                            _animeGridBuilder(context),
                          ],
                        ),
                      ),
                      FollowingPage(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _animeGridBuilder(BuildContext context) {
    Future<List<Anime>> animes = AnimesApi.getAnimes();
    return FutureBuilder<List<Anime>>(
      future: animes,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.orange,
            ),
          );
        }
        List<Anime> animes = snapshot.data;
        return _animeGrid(context, animes);
      },
    );
  }

  _animeGrid(context, animes) {
    //print(_messaging);
    return AnimesGridView(animes, _messaging);
  }

  createUserDB(userToken, deviceType) {
    print(userToken);
    var jsonBody = {
      "id_user": userToken,
      "deviceType": deviceType,
      "animes": []
    };
    print(json.encode(jsonBody));
    Map<String, String> headers = {"Content-Type": "application/json"};
    //print(jsonEncode(jsonBody));
    http
        .put("https://platy-pus.herokuapp.com/api/addUser",
            body: json.encode(jsonBody), headers: headers)
        .then((response) => print(response.body));
  }
}
