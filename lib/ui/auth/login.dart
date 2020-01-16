import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import '../../utils/onWillPop.dart';
import '../components/leftChangeTheme.dart';
import '../components/primaryButton.dart';
import '../components/baseTextField.dart';
import '../../utils/styles.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
        final pop = await OnWillPop().dialog(context);
        if (pop) {
          exit(0);
        }
        return;
      },
      child: Scaffold(
          body: Container(
            width: MediaQuery.of(context).size.width,
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
                                  'Already',
                                  style: theme.textTheme.headline
                                      .copyWith(color: theme.accentColor),
                                ),
                                Text(
                                  'have an',
                                  style: theme.textTheme.headline
                                      .copyWith(color: theme.accentColor),
                                ),
                                Text(
                                  'Account?',
                                  style: theme.textTheme.headline
                                      .copyWith(color: theme.accentColor),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            margin: EdgeInsets.only(left: 10, top: 80),
                            child: Image.asset(
                              'assets/flutter-logo.png',
                              color: theme.accentColor,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(40),
                        margin: EdgeInsets.only(top: 40),
                        child: Column(
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.symmetric(vertical: 20),
                                child: BaseTextField(
                                    textAlign: TextAlign.center,
                                    labelText: 'Username')),
                            Container(
                                margin: EdgeInsets.symmetric(vertical: 20),
                                child: BaseTextField(
                                    textAlign: TextAlign.center,
                                    labelText: 'Password',
                                    obscureText: true)),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: PrimaryButton(
                                  labelText: 'L o g i n',
                                  width: 200,
                                  loading: loading,
                                  onPressed: () {
                                    setState(() {
                                      loading = true;
                                    });
                                    new Timer(
                                        const Duration(milliseconds: 1000), () {
                                      Navigator.pushNamed(context, 'dashboard/0');
                                    });
                                  }),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, 'register');
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Register',
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
