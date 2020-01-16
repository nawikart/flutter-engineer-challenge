import 'package:flutter/material.dart';
import 'dart:async';
import '../components/leftChangeTheme.dart';
import '../components/primaryButton.dart';
import '../components/baseTextField.dart';
import '../../utils/styles.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, '/');
        return;
      },
      child: Scaffold(
          body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 20),
        color: theme.backgroundColor,
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 30, top: 90),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'It\'s free',
                              style: theme.textTheme.headline
                                  .copyWith(color: theme.accentColor),
                            ),
                            Text(
                              'to register',
                              style: theme.textTheme.headline
                                  .copyWith(color: theme.accentColor),
                            ),
                            Text(
                              'today!',
                              style: theme.textTheme.headline
                                  .copyWith(color: theme.accentColor),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        margin: EdgeInsets.only(left: 10, top: 30),
                        child: Image.asset(
                          'assets/flutter-logo.png',
                          color: theme.accentColor,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            child: BaseTextField(
                                rounded: true,
                                textAlign: TextAlign.center,
                                labelText: 'Fullname')),
                        Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            child: BaseTextField(
                                rounded: true,
                                textAlign: TextAlign.center,
                                labelText: 'Email')),
                        Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            child: BaseTextField(
                                rounded: true,
                                textAlign: TextAlign.center,
                                labelText: 'Gender')),
                        Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            child: BaseTextField(
                                rounded: true,
                                textAlign: TextAlign.center,
                                labelText: 'Phone')),
                        Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            child: BaseTextField(
                                rounded: true,
                                textAlign: TextAlign.center,
                                labelText: 'Address')),
                        Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            child: BaseTextField(
                                rounded: true,
                                textAlign: TextAlign.center,
                                labelText: 'D.O.B')),
                        Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            child: BaseTextField(
                                rounded: true,
                                maxLines: 5,
                                textAlign: TextAlign.center,
                                labelText: 'About')),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: PrimaryButton(
                              labelText: 'R e g i s t e r',
                              width: 200,
                              loading: loading,
                              onPressed: () {
                                setState(() {
                                  loading = true;
                                });
                                new Timer(const Duration(milliseconds: 1000),
                                    () {
                                  Navigator.pushNamed(context, 'dashboard/0');
                                });
                              }),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('L o g i n',
                                style: CustomTextStyle.smallLink(context)),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            LeftChangeTheme()
          ],
        ),
      )),
    );
  }
}
