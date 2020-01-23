import 'package:flutter/material.dart';
import 'dart:io';
import '../components/mainDrawer.dart';
import '../components/dynamicTheme/themeSwitcherDialog.dart';
import '../../utils/onWillPop.dart';
import '../components/clippers/wave.dart';
import '../components/dynamicTheme/dynamicTheme.dart';

import 'home/index.dart';
import 'shows/index.dart';
import 'friends/index.dart';
import 'me/index.dart';

class DashboardPage extends StatefulWidget {
  final String index;
  DashboardPage({this.index});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
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
      {'title': 'Shows', 'page': ShowsPage()},
      {'title': 'Friends', 'page': FriendsPage()},
      {'title': 'Me', 'page': MePage()}
    ];

    super.initState();
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
                icon: Icon(
                  Icons.menu,
                  color: theme.backgroundColor,
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
            style: TextStyle(color: theme.backgroundColor),
          ),
          actions: <Widget>[
            InkWell(
              onTap: () async {
                await ThemeSwitcherDialog().selectColor(context);
              },
              child: Container(
                  margin: EdgeInsets.only(right: 10),
                  child:
                      Icon(Icons.invert_colors, color: theme.backgroundColor)),
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
              icon: Icon(Icons.live_tv),
              title: Text('Shows', style: TextStyle(fontSize: 10)),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group),
              title: Text('Friends', style: TextStyle(fontSize: 10)),
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
