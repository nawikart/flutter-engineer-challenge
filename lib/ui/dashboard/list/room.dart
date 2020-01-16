import 'package:flutter/material.dart';
import '../../../utils/styles.dart';
import '../../components/mainDrawer.dart';
import '../../components/leftTopMenu.dart';

class RoomPage extends StatefulWidget {
  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  bool loading = true;
  Map data;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, 'dashboard/1');
        return;
      },
      child: Scaffold(
          drawer: MainDrawer(),
          body: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 20),
            color: theme.backgroundColor,
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        height: 100,
                        padding: EdgeInsets.only(top: 46, left: 80),
                        child: Text(
                          'ROOM',
                          style: theme.textTheme.title,
                        )),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 150,
                      child: Center(
                        child: SingleChildScrollView(
                          child: Container(
                            padding: const EdgeInsets.all(40),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Text(
                                    'ON PROGRESS',
                                    style: theme.textTheme.display1,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, 'dashboard/1');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('b a c k',
                                        style: CustomTextStyle.smallLink(
                                            context)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                LeftTopMenu()
              ],
            ),
          )),
    );
  }
}
