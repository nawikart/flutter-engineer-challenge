import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
        height: MediaQuery.of(context).size.height - 250,
        child: Center(
          child: Container(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(
              backgroundColor: theme.backgroundColor,
              strokeWidth: 1,
            ),
          ),
        ));
  }
}
