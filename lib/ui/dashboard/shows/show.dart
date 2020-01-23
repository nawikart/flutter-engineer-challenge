import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/myProvider.dart';
import '../../../model/tvMaze/show.dart';
import '../../../utils/styles.dart';
import '../../components/mainDrawer.dart';
import '../../components/leftTopMenu.dart';

class ShowPage extends StatefulWidget {
  final String id;
  ShowPage(this.id);

  @override
  _ShowPageState createState() => _ShowPageState();
}

class _ShowPageState extends State<ShowPage> {
  bool loading = true;
  Show show;
  int counter = 0;

  @override
  void initState() {
    super.initState();
  }

  void selectedShow() {
    var myProvider = Provider.of<MyProvider>(context);
    setState(() {
      show = myProvider.selectedShow;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (counter == 0) {
      counter++;
      selectedShow();
    }
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
          drawer: MainDrawer(),
          body: Center(
            child: (show == null)
                ? Text('Not Found')
                : Container(
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
                                  'SHOW',
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
                                            show.name ?? 'undefined',
                                            style: theme.textTheme.display2,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('b a c k',
                                                style:
                                                    CustomTextStyle.smallLink(
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
                  ),
          )),
    );
  }
}
