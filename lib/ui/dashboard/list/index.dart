import 'package:flutter/material.dart';
import 'dart:async';
import '../../../api/friends.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  bool loading = true;
  List data = [];

  @override
  void initState() {
    super.initState();
    getFriends();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return (loading)
        ? Padding(
            padding: const EdgeInsets.all(100),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(
                strokeWidth: 1,
              ),
            ),
          )
        : Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                for (int i = 0; i < data.length; i++)
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, 'friends/room');
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 4),
                      child: Card(
                          elevation: 4,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: Colors.white,
                          child: Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                      color: Colors.red,
                                      height: 70,
                                      child:
                                          Image.asset('assets/avatar.jpeg')),
                                  Container(
                                      color: Colors.white,
                                      height: 70,
                                      width: MediaQuery.of(context).size.width -
                                          150,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 8, 8, 2),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              data[i]['name'] ?? '',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color: theme.primaryColor),
                                            ),
                                            Text(
                                              data[i]['address'] ?? '',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: theme.primaryColor),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 9),
                                              child: Row(
                                                children: <Widget>[
                                                  Icon(Icons.av_timer,
                                                      size: 12,
                                                      color:
                                                          theme.primaryColor),
                                                  Text(
                                                    ' 5 hours ago',
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color:
                                                            theme.primaryColor),
                                                  ),
                                                  Spacer(),
                                                  Icon(Icons.chat,
                                                      size: 12,
                                                      color:
                                                          theme.primaryColor),
                                                  Text(
                                                    ' 2   ',
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color:
                                                            theme.primaryColor),
                                                  ),
                                                  Icon(Icons.call,
                                                      size: 12,
                                                      color:
                                                          theme.primaryColor),
                                                  Text(
                                                    ' 2',
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color:
                                                            theme.primaryColor),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                  Spacer(),
                                  Container(
                                    height: 70,
                                    color: Colors.grey,
                                    width: 30,
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ))),
                    ),
                  ),
              ],
            ),
          );
  }

  void getFriends() async {
    final res = await FriendsApi().list(context);
//    print(res);
    new Timer(const Duration(milliseconds: 750), () {
      setState(() {
        data = res;
        loading = false;
      });
    });
  }
}
