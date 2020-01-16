import 'package:flutter/material.dart';
import '../../components/primaryButton.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 65, 20, 40),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Text(
                'WELCOME TO MY FIRST VERSION APP',
                style: theme.textTheme.title.copyWith(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            Text('FLUTTER ENGINEER CHALLENGE',
                style: theme.textTheme.display1.copyWith(fontSize: 28),
                textAlign: TextAlign.center),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                  'Please feel free to test me adding any feature here...',
                  style: theme.textTheme.subtitle,
                  textAlign: TextAlign.center),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: PrimaryButton(
                  labelText: 'S t a r t',
                  width: 200,
                  onPressed: () {
                    Navigator.pushNamed(context, 'dashboard/1');
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
