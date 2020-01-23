import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/users.dart';
import '../components/leftChangeTheme.dart';
import '../components/primaryButton.dart';
import '../components/baseTextField.dart';
import '../../utils/styles.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  bool loading = false;
  List invalidMsg = [];
  Map data = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/');
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
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              child: BaseTextField(
                                  rounded: true,
                                  textAlign: TextAlign.center,
                                  labelText: 'Firstname',
                                  onSaved: (String v) {
                                    data['first_name'] = v;
                                  })),
                          Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              child: BaseTextField(
                                  rounded: true,
                                  textAlign: TextAlign.center,
                                  labelText: 'Lastname',
                                  onSaved: (String v) {
                                    data['last_name'] = v;
                                  })),
                          Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              child: BaseTextField(
                                  hintText: 'male / female',
                                  rounded: true,
                                  textAlign: TextAlign.center,
                                  labelText: 'Gender',
                                  onSaved: (String v) {
                                    data['gender'] = v.toLowerCase();
                                  })),
                          Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              child: BaseTextField(
                                  rounded: true,
                                  hintText: 'eg. 2000-31-12',
                                  textAlign: TextAlign.center,
                                  labelText: 'D.O.B',
                                  onSaved: (String v) {
                                    data['dob'] = v;
                                  })),
                          Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              child: BaseTextField(
                                  rounded: true,
                                  textAlign: TextAlign.center,
                                  labelText: 'Email',
                                  onSaved: (String v) {
                                    data['email'] = v;
                                  })),
                          Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              child: BaseTextField(
                                  rounded: true,
                                  textAlign: TextAlign.center,
                                  labelText: 'Phone',
                                  onSaved: (String v) {
                                    data['phone'] = v;
                                  })),
                          Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              child: BaseTextField(
                                  rounded: true,
                                  textAlign: TextAlign.center,
                                  labelText: 'Website',
                                  onSaved: (String v) {
                                    data['website'] = v;
                                  })),
                          Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              child: BaseTextField(
                                  rounded: true,
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                  labelText: 'Address',
                                  onSaved: (String v) {
                                    data['address'] = v;
                                  })),
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
//
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: PrimaryButton(
                                labelText: 'R e g i s t e r',
                                width: 200,
                                loading: loading,
                                onPressed: () async {
                                  if (!loading) {
                                    setState(() {
//                                      loading = true;
                                      invalidMsg = [];
                                    });

                                    formKey.currentState.save();
                                    final res = await Users().create(data);
                                    if (res['_meta']['success']) {
                                      // save to local storage
                                      final stringMe =
                                          json.encode(res['result']);
                                      final prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setString('me', stringMe);
                                      Navigator.pushReplacementNamed(
                                          context, 'dashboard/0');
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
                              Navigator.pushReplacementNamed(context, '/');
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('L o g i n',
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
