import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/dynamicTheme/themeSwitcherDialog.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Drawer(
      child: Container(
          color: theme.backgroundColor,
          child: Center(
            child: Container(
              margin: EdgeInsets.only(top: 100),
              child: Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, 'dashboard/0');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Home',
                        style: theme.textTheme.headline,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, 'dashboard/1');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Shows',
                        style: theme.textTheme.headline,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, 'dashboard/2');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Friends',
                        style: theme.textTheme.headline,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, 'dashboard/3');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Me',
                        style: theme.textTheme.headline,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      preferences.clear();

                      Navigator.pushReplacementNamed(context, '/');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Logout',
                        style: theme.textTheme.headline,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    child: InkWell(
                      onTap: () async {
                        Navigator.of(context).pop();
                        await ThemeSwitcherDialog().selectColor(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'change theme',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: theme.accentColor,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
