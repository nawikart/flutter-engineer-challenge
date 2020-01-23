import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/users.dart';
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
  final formKey = GlobalKey<FormState>();
  bool loading = false;
  List invalidMsg = [];
  String email = '';

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getString('me') != null) {
        Navigator.pushReplacementNamed(context, '/dashboard/0');
      }
    });
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
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.symmetric(vertical: 20),
                              child: BaseTextField(
                                  textAlign: TextAlign.center,
                                  onSaved: (String v) {
                                    email = v;
                                  },
                                  labelText: 'Email')),
                          Container(
                              margin: EdgeInsets.symmetric(vertical: 20),
                              child: BaseTextField(
                                  textAlign: TextAlign.center,
                                  labelText: 'Password',
                                  obscureText: true)),
                          Container(
                            padding: const EdgeInsets.only(top: 20),
                            child: Column(
                              children: <Widget>[
                                for (int i = 0; i < invalidMsg.length; i++)
                                  Text(invalidMsg[i]['message'] ?? '',
                                      textAlign: TextAlign.center,
                                      style:
                                          CustomTextStyle.errorText(context)),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: PrimaryButton(
                                labelText: 'L o g i n',
                                width: 200,
                                loading: loading,
                                onPressed: () async {
                                  if (!loading) {
                                    setState(() {
                                      loading = true;
                                      invalidMsg = [];
                                    });
                                    formKey.currentState.save();
                                    if (email == '') {
                                      invalidMsg
                                          .add({'message': 'Email required'});
                                      setState(() {
                                        loading = false;
                                      });
                                      return;
                                    }
                                    final res = await Users().getByEmail(email);
                                    if (res['_meta']['success']) {
                                      if (res['result'].length > 0) {
                                        // save to local storage
                                        final stringMe =
                                            json.encode(res['result'][0]);
                                        final prefs = await SharedPreferences
                                            .getInstance();
                                        prefs.setString('me', stringMe);

                                        Navigator.pushReplacementNamed(
                                            context, 'dashboard/0');
                                      } else {
                                        invalidMsg
                                            .add({'message': 'Not Found'});
                                      }
                                    } else {
                                      if (res['result'][0] == null) {
                                        invalidMsg.add(res['result']);
                                      } else {
                                        invalidMsg = res['result'];
                                      }
                                    }

                                    setState(() {
                                      loading = false;
                                    });
                                  }
                                }),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, 'register');
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Register',
                                  style: CustomTextStyle.smallLink(context)),
                            ),
                          )
                        ],
                      ),
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
