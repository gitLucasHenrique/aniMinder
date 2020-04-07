import 'dart:convert';
import 'dart:ui';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:animinder/animes/anime.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class AnimeDetails extends StatefulWidget {
  final Anime anime;
  final FirebaseMessaging token;
  AnimeDetails({this.anime, this.token});
  @override
  _AnimeDetailsState createState() => _AnimeDetailsState();
}

class _AnimeDetailsState extends State<AnimeDetails> {
  bool _fav = false;
  bool teste = true;

  @override
  Widget build(BuildContext context) {
    final generos = widget.anime.generos.trim().split(',');
    return Scaffold(
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Colors.orange[800],
        overlayColor: Colors.transparent,
        onOpen: () => print("open"),
        onClose: () => print("close"),
        children: [
          SpeedDialChild(
            child: FutureBuilder(
              future: _checkFavorite(widget.token, widget.anime),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return CircularProgressIndicator();
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  default:
                    if (snapshot.hasError)
                      return Icon(Icons.error);
                    else {
                      _fav = snapshot.data;
                      print("valor de _fav $_fav");
                      return (snapshot.data)
                          ? Icon(Icons.favorite)
                          : Icon(Icons.favorite_border);
                    }
                }
              },
            ),
            backgroundColor: (Colors.red),
            foregroundColor: (Colors.white),
            labelStyle: TextStyle(fontSize: 20.0),
            onTap: () => _toggleFav(widget.anime, widget.token),
          ),
          SpeedDialChild(
            child: Icon(Icons.arrow_back_ios),
            backgroundColor: Colors.greenAccent,
            foregroundColor: Colors.white,
            labelStyle: TextStyle(fontSize: 20.0),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Container(
        color: Colors.deepOrange,
        child: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Colors.orange[600],
                leading: Container(),
                expandedHeight: MediaQuery.of(context).size.width + 100,
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: widget.anime.img,
                    child: Image.network(
                      widget.anime.img,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Container(
                      color: Colors.grey[200],
                      //margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        //padding: EdgeInsets.symmetric(horizontal: 20),
                        //margin: EdgeInsets.symmetric(horizontal: 20),
                        color: Colors.transparent,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 8,
                                  child: Container(
                                    alignment: (widget.anime.name.length > 10)
                                        ? Alignment.centerLeft
                                        : Alignment.center,
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    margin: EdgeInsets.only(left: 20),
                                    //color: Colors.green,
                                    child: Text(
                                      widget.anime.name,
                                      style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      color: checkColor(
                                          widget.anime.classificacao),
                                    ),
                                    child: Center(
                                      child: Text(
                                        widget.anime.classificacao,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                (widget.anime.classificacao ==
                                                        "18")
                                                    ? Colors.white
                                                    : Colors.black87),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 5, 10, 10),
                              child: Divider(
                                color: Colors.deepOrange,
                                thickness: 1,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                              decoration: BoxDecoration(
                                  color: Colors.white60,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              margin: EdgeInsets.only(
                                top: 5,
                                bottom: 20,
                              ),
                              child: Center(
                                child: Text(
                                  widget.anime.sinopse,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                              child: Divider(
                                color: Colors.deepOrange,
                                thickness: 1,
                              ),
                            ),
                            Container(
                              height: 40,
                              child: ListView.separated(
                                separatorBuilder: (_, index) => SizedBox(
                                  width: 10,
                                ),
                                itemCount: generos.length,
                                scrollDirection: Axis.horizontal,
                                //physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (_, index) => Container(
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    color: Colors.black87,
                                  ),
                                  child: Center(
                                    child: Text(
                                      (generos[index].split(' ').length > 2)
                                          ? generos[index].split(' ')[1] +
                                              ' ' +
                                              generos[index].split(' ')[2][0] +
                                              '.'
                                          : generos[index],
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 15, 10, 5),
                              child: Divider(
                                color: Colors.deepOrange,
                                thickness: 1,
                              ),
                            ),
                            Container(
                              height: 140,
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    decoration: BoxDecoration(
                                      color: Colors.white60,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          child: (widget.anime.dayOTW == 6 ||
                                                  widget.anime.dayOTW == 0)
                                              ? Text(
                                                  "Transmitido todo " +
                                                      widget.anime
                                                          .checkDayOTW(widget
                                                              .anime.dayOTW)
                                                          .toLowerCase() +
                                                      " às :",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 17),
                                                )
                                              : Text(
                                                  "Transmitido toda " +
                                                      widget.anime
                                                          .checkDayOTW(widget
                                                              .anime.dayOTW)
                                                          .toLowerCase() +
                                                      " às :",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 17),
                                                ),
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                child: Image(
                                                  image: AssetImage(
                                                      'assets/img/bandeira-br.jpg'),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                child: Text(
                                                  widget.anime.transmiBR,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 15),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                child: Image(
                                                  image: AssetImage(
                                                      'assets/img/bandeira-jp.jpg'),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                child: Text(
                                                  widget.anime.transmiJP,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 15),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left:
                                        MediaQuery.of(context).size.width / 20,
                                    right:
                                        MediaQuery.of(context).size.width / 20,
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.horizontal(
                                            left: Radius.elliptical(100, 100),
                                            right: Radius.elliptical(100, 100),
                                          ),
                                          color: Colors.white30,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.9),
                                            )
                                          ]),
                                      child: Center(
                                        child: Text(
                                          "by " + widget.anime.estudio,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 80,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _toggleFav(anime, token) {
    Anime a = anime;
    FirebaseMessaging fbm = token;
    fbm.getToken().then((tkn) => _sendPostFav(a, tkn));
  }

  _sendPostFav(anime, token) {
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
              if (_fav) {
                print("retirado do favorito");
                _fav = false;
              } else {
                _fav = true;
                print("favoritado");
              }
            },
          ),
        );
  }
}

checkColor(String classificacao) {
  switch (classificacao) {
    case "10":
      return Colors.lightBlueAccent;
      break;
    case "12":
      return Colors.yellow;
      break;
    case "14":
      return Colors.deepOrange;
      break;
    case "16":
      return Colors.red;
      break;
    case "18":
      return Colors.black87;
      break;
    case "L":
      return Colors.green;
      break;
    default:
      return Colors.yellowAccent;
  }
}

Future<bool> _checkFavorite(userToken, animeName) async {
  //FirebaseMessaging token = userToken;
  Anime a = animeName;
  var t = await userToken.getToken();
  print(t);
  var jsonBody = {"id_user": t, "animeName": a.name};
  var headers = {"Content-type": "application/json", "Secret-One": "Platypus"};
  final response = await http.post(
      'https://platy-pus.herokuapp.com/api/checkUserFav',
      body: json.encode(jsonBody),
      headers: headers);
  return (response.body == "true" ? true : false);
}
