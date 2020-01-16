import 'package:flutter/material.dart';
import 'dynamicTheme.dart';

class ThemeSwitcherDialog {
  Future<String> selectColor(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: Text('Select theme color'),
        content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    child: Text(
                      'Dark',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Color(0xff2749BE),
                    onPressed: () {
                      DynamicTheme.of(context)
                          .setThemeData('dark');
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    child: Text(
                      'Light',
                      style: TextStyle(color: Colors.black),
                    ),
                    color: Color(0xfffafafa),
                    onPressed: () {
                      DynamicTheme.of(context)
                          .setThemeData('light');
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            )),
      ),
    ) ??
        false;
  }
}
