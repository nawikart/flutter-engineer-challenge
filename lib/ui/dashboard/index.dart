import 'package:flutter/material.dart';
import 'dart:io';
import '../components/mainDrawer.dart';
import '../components/dynamicTheme/themeSwitcherDialog.dart';
import '../../utils/onWillPop.dart';
import '../components/clippers/wave.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home/index.dart';
import 'list/index.dart';
import 'me/index.dart';

class DashboardPage extends StatefulWidget {
  final String index;
  DashboardPage({this.index});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String themeColor = 'dark';
  int _selectedPageIndex = 0;
  List<Map<String, Object>> _pages;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    _selectedPageIndex = int.parse(widget.index) ?? 0;
    _pages = [
      {'title': 'Home', 'page': HomePage()},
      {'title': 'Friends', 'page': ListPage()},
      {'title': 'Me', 'page': MePage()}
    ];

    super.initState();

    checkThemeColor().then((result) {
      setState(() {
        themeColor = result;
      });
    });
  }

  checkThemeColor() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('themeColor');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return WillPopScope(
      onWillPop: () async {
        final pop = await OnWillPop().dialog(context);
        if (pop) {
          exit(0);
        }
        return;
      },
      child: Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: theme.accentColor,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: (themeColor == 'dark')
                    ? const Icon(
                        Icons.menu,
                        color: Colors.blue,
                      )
                    : const Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          title: Text(
            _pages[_selectedPageIndex]['title'] ?? '',
            style: TextStyle(
                color: (themeColor == 'dark') ? Colors.blue : Colors.white),
          ),
          actions: <Widget>[
            InkWell(
              onTap: () async {
                await ThemeSwitcherDialog().selectColor(context);
                checkThemeColor().then((result) {
                  setState(() {
                    themeColor = result;
                  });
                });
              },
              child: Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Icon(Icons.invert_colors,
                      color:
                          (themeColor == 'dark') ? Colors.blue : Colors.white)),
            )
          ],
        ),
        body: Container(
          color: theme.backgroundColor,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ClipPath(
                  clipper: Wave(),
                  child: Container(
                    color: theme.accentColor,
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height - 190,
                  child: SingleChildScrollView(
                    child: _pages[_selectedPageIndex]['page'] ?? null,
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          onTap: _selectPage,
          backgroundColor: theme.backgroundColor,
          unselectedItemColor: Colors.blueGrey,
          selectedItemColor: theme.accentColor,
          currentIndex: _selectedPageIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home', style: TextStyle(fontSize: 10)),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              title: Text('List', style: TextStyle(fontSize: 10)),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text('Me', style: TextStyle(fontSize: 10)),
            ),
          ],
        ),
      ),
    );
  }
}
