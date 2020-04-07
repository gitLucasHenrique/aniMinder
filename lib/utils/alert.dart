import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void alert(context, {String title = "Flutter", String msg, Function callback}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: title != null && title.isNotEmpty
            ? Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                ),
              )
            : null,
        content: msg != null && msg.isNotEmpty
            ? Text(
                msg,
                style: TextStyle(
                  color: Colors.black,
                ),
              )
            : null,
        actions: <Widget>[
          FlatButton(
            child: Text(
              "OK",
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
              if (callback != null) {
                callback();
              }
            },
          ),
        ],
      );
    },
  );
}