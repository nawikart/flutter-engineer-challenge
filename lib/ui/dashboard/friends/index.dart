import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import '../../../providers/myProvider.dart';
import '../../components/loadingPage.dart';
import '../../../api/users.dart';
import '../../../model/user.dart';

class FriendsPage extends StatefulWidget {
  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  bool loading = true;
  Future<List<User>> users;

  @override
  void initState() {
    super.initState();
    users = Users().list();
  }

  @override
  Widget build(BuildContext context) {
    var myProvider = Provider.of<MyProvider>(context);
    return Container(
      padding: EdgeInsets.all(20),
      child: FutureBuilder<List<User>>(
        future: users,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return new LoadingPage();
            default:
              if (snapshot.hasError)
                return Center(
                    child: new Text(
                      'Error: ${snapshot.error}',
                      style: TextStyle(color: Colors.red),
                    ));
              else if (snapshot.data.length == 0)
                return Center(
                  child: Text('Not Found', style: TextStyle(color: Colors.red)),
                );
              if (snapshot.data.length > 0)
                new Timer(const Duration(seconds: 1), () {
                });
              return Container(
                child: Column(
                  children: <Widget>[
                    for (int i = 0;
                    i <
                        ((snapshot.data.length > 25)
                            ? 25
                            : snapshot.data.length);
                    i++)
                      _item(snapshot.data[i])
                  ],
                ),
              );
          }
        },
      ),
    );
  }

  Widget _item(User user) {
    final theme = Theme.of(context);
    return InkWell(
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
                        height: 70,
                        width: 70,
                        child: Stack(
                          children: <Widget>[
                            SizedBox(child: Icon(Icons.account_box, size: 70, color: Colors.grey,)),
                            Image.network(user.avatar),
                          ],
                        )),
                    Container(
                        color: Colors.white,
                        height: 70,
                        width: MediaQuery.of(context).size.width - 160,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 9, 4, 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                user.displayName,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: theme.primaryColor),
                              ),
                              Text(
                                '${user.email}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 10, color: Colors.blueGrey),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.phone,
                                        size: 12, color: theme.primaryColor),
                                    Container(
                                      padding: EdgeInsets.only(left: 4),
                                      child: Text(
                                        '${user.phone}',
                                        style: TextStyle(
                                            fontSize: 9,
                                            color: theme.primaryColor),
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(Icons.accessibility,
                                        size: 12, color: theme.primaryColor),
                                    Text(
                                      ' ' + user.gender,
                                      style: TextStyle(
                                          fontSize: 9,
                                          color: theme.primaryColor),
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
    );
  }
}
