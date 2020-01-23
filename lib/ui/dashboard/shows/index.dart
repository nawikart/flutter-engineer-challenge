import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import '../../../providers/myProvider.dart';
import '../../components/loadingPage.dart';
import '../../../api/tvMaze.dart';
import '../../../model/tvMaze/show.dart';

class ShowsPage extends StatefulWidget {
  @override
  _ShowsPageState createState() => _ShowsPageState();
}

class _ShowsPageState extends State<ShowsPage> {
  bool loading = true;
  Future<List<Show>> shows;

  @override
  void initState() {
    super.initState();
    shows = TvMaze().fetchListShow();
  }

  @override
  Widget build(BuildContext context) {
    var myProvider = Provider.of<MyProvider>(context);
    return Container(
      padding: EdgeInsets.all(20),
      child: FutureBuilder<List<Show>>(
        future: shows,
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

  Widget _item(Show show) {
    var myProvider = Provider.of<MyProvider>(context);
    final theme = Theme.of(context);

    return InkWell(
      onTap: () async {
        await myProvider.setSelectedShow(show);
        Navigator.pushNamed(context, 'shows/${show.id}');
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
                        width: 50,
                        child: Stack(
                          children: <Widget>[
                            SizedBox(
                                child: Icon(
                              Icons.image,
                              size: 50,
                              color: Colors.grey,
                            )),
                            Image.network(show.image),
                          ],
                        )),
                    Container(
                        color: Colors.white,
                        height: 70,
                        width: MediaQuery.of(context).size.width - 140,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12, 9, 4, 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                show.name,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: theme.primaryColor),
                              ),
                              Text(
                                '${show.type} / ${show.network}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 10, color: Colors.blueGrey),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.access_time,
                                        size: 12, color: theme.primaryColor),
                                    Container(
                                      padding: EdgeInsets.only(left: 4),
                                      child: Text(
                                        show.schedule,
                                        style: TextStyle(
                                            fontSize: 9,
                                            color: theme.primaryColor),
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(Icons.rate_review,
                                        size: 12, color: theme.primaryColor),
                                    Text(
                                      ' ' + show.rating.toString(),
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
