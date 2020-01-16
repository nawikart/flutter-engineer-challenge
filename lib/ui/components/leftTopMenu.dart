import 'package:flutter/material.dart';
import '../components/clippers/leftMenu.dart';

class LeftTopMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 0),
          decoration: new BoxDecoration(
              color: theme.accentColor,
              borderRadius: new BorderRadius.only(
                  topRight: const Radius.circular(150.0),
                  bottomRight: const Radius.circular(150.0))),
          width: 8,
          height: MediaQuery.of(context).size.height - 100,
        ),
        InkWell(
          onTap: () async {
            Scaffold.of(context).openDrawer();
          },
          child: Container(
//                color: Colors.red,
            margin: EdgeInsets.only(
                top:10),
            child: ClipPath(
              clipper: ClipperLeftMenu(),
              child: Container(
                height: 80,
                width: 60,
                color: theme.accentColor,
                child: Icon(
                  Icons.menu,
                  color: theme.backgroundColor,
                ),
              ),
            ),
          ),
        )],
    );
  }
}
