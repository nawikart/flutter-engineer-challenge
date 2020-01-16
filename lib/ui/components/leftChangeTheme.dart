import 'package:flutter/material.dart';
import '../components/dynamicTheme/themeSwitcherDialog.dart';
import '../components/clippers/leftMenu.dart';

class LeftChangeTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 50),
          decoration: new BoxDecoration(
              color: theme.accentColor,
              borderRadius: new BorderRadius.only(
                  topRight: const Radius.circular(150.0),
                  bottomRight: const Radius.circular(150.0))),
          width: 8,
          height: MediaQuery.of(context).size.height,
        ),
        InkWell(
          onTap: () async {
            await ThemeSwitcherDialog().selectColor(context);
          },
          child: Container(
//                color: Colors.red,
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height - 100),
            child: ClipPath(
              clipper: ClipperLeftMenu(),
              child: Container(
                height: 150,
                width: 40,
                color: theme.accentColor,
                child: Icon(
                  Icons.invert_colors,
                  color: theme.backgroundColor,
                ),
              ),
            ),
          ),
        )],
    );
  }
}
