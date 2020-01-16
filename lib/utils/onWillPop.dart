import 'package:flutter/material.dart';

class OnWillPop {
  Future<bool> dialog(context) {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            content: new Text('Are you sure to quit the app?'),
            actions: <Widget>[
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          ),
        ) ??
        false;
  }
}
