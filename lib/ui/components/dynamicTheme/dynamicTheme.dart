import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef ThemedWidgetBuilder = Widget Function(
    BuildContext context, ThemeData data);

class DynamicTheme extends StatefulWidget {
  const DynamicTheme({Key key, this.themedWidgetBuilder, this.defaultColor})
      : super(key: key);

  final ThemedWidgetBuilder themedWidgetBuilder;
  final String defaultColor;

  @override
  DynamicThemeState createState() => DynamicThemeState();

  static DynamicThemeState of(BuildContext context) {
    return context.ancestorStateOfType(const TypeMatcher<DynamicThemeState>());
  }
}

class DynamicThemeState extends State<DynamicTheme> {
  ThemeData _data;

  @override
  void initState() {
    super.initState();
    setThemeData(widget.defaultColor);
  }

  void setThemeData(String color) async {
    switch (color) {
      case 'dark':
        {
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('themeColor', color);

          setState(() {
            _data = ThemeData(
                fontFamily: 'GothamRounded',
                brightness: Brightness.dark,
                primaryColor: Color(0xff173984),
                accentColor: Colors.white,
                backgroundColor: Color(0xff173984),
                dialogBackgroundColor: Colors.blueAccent);
          });
        }
        break;

      case 'light':
        {
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('themeColor', color);

          setState(() {
            _data = ThemeData(
                fontFamily: 'GothamRounded',
                primaryColor: Color(0xff173984),
                accentColor: Color(0xff173984),
                backgroundColor: Colors.white);
          });
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.themedWidgetBuilder(context, _data);
  }
}
