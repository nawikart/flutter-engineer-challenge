import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import '../../../utils/styles.dart';
import '../../components/loadingPage.dart';
import '../../components/mainDrawer.dart';
import '../../components/leftTopMenu.dart';
import '../../components/primaryButton.dart';
import '../../components/baseTextField.dart';
import '../../../api/users.dart';

class MeEditPage extends StatefulWidget {
  @override
  _MeEditPageState createState() => _MeEditPageState();
}

class _MeEditPageState extends State<MeEditPage> {
  bool saveLoading = false;
  Map data;
  List invalidMsg = [];

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((prefs) {
      data = json.decode(prefs.getString('me'));
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
          drawer: MainDrawer(),
          body: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
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
                            'EDIT ME',
                            style: theme.textTheme.title,
                          )),
                      (data == null)
                          ? LoadingPage()
                          : Container(
                              height: MediaQuery.of(context).size.height - 150,
                              child: SingleChildScrollView(
                                child: Container(
                                  padding: const EdgeInsets.all(40),
                                  child: Form(
                                    key: formKey,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                            margin:
                                                EdgeInsets.symmetric(vertical: 5),
                                            child: BaseTextField(
                                                initialValue: data['first_name'],
                                                rounded: true,
                                                textAlign: TextAlign.center,
                                                labelText: 'Firstname',
                                                onSaved: (String v) {
                                                  data['first_name'] = v;
                                                })),
                                        Container(
                                            margin:
                                                EdgeInsets.symmetric(vertical: 5),
                                            child: BaseTextField(
                                                initialValue: data['last_name'],
                                                rounded: true,
                                                textAlign: TextAlign.center,
                                                labelText: 'Lastname',
                                                onSaved: (String v) {
                                                  data['last_name'] = v;
                                                })),
                                        Container(
                                            margin:
                                                EdgeInsets.symmetric(vertical: 5),
                                            child: BaseTextField(
                                                rounded: true,
                                                initialValue: data['gender'],
                                                textAlign: TextAlign.center,
                                                labelText: 'Gender',
                                                onSaved: (String v) {
                                                  data['gender'] = v;
                                                })),
                                        Container(
                                            margin:
                                                EdgeInsets.symmetric(vertical: 5),
                                            child: BaseTextField(
                                                rounded: true,
                                                initialValue: data['dob'],
                                                textAlign: TextAlign.center,
                                                labelText: 'D.O.B',
                                                onSaved: (String v) {
                                                  data['dob'] = v;
                                                })),
                                        Container(
                                            margin:
                                                EdgeInsets.symmetric(vertical: 5),
                                            child: BaseTextField(
                                                rounded: true,
                                                initialValue: data['email'],
                                                textAlign: TextAlign.center,
                                                labelText: 'Email',
                                                onSaved: (String v) {
                                                  data['email'] = v;
                                                })),
                                        Container(
                                            margin:
                                                EdgeInsets.symmetric(vertical: 5),
                                            child: BaseTextField(
                                                rounded: true,
                                                initialValue: data['phone'],
                                                textAlign: TextAlign.center,
                                                labelText: 'Phone',
                                                onSaved: (String v) {
                                                  data['phone'] = v;
                                                })),
                                        Container(
                                            margin:
                                                EdgeInsets.symmetric(vertical: 5),
                                            child: BaseTextField(
                                                rounded: true,
                                                initialValue: data['website'],
                                                textAlign: TextAlign.center,
                                                labelText: 'Website',
                                                onSaved: (String v) {
                                                  data['website'] = v;
                                                })),
                                        Container(
                                            margin:
                                                EdgeInsets.symmetric(vertical: 5),
                                            child: BaseTextField(
                                                rounded: true,
                                                initialValue: data['address'],
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
                                              for (int i = 0;
                                                  i < invalidMsg.length;
                                                  i++)
                                                Text(
                                                    invalidMsg[i]['message'] ??
                                                        '',
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        CustomTextStyle.errorText(
                                                            context)),
                                            ],
                                          ),
                                        ),
//
                                        Container(
                                          margin: const EdgeInsets.only(top: 10),
                                          child: PrimaryButton(
                                              labelText: 'U p d a t e',
                                              width: 200,
                                              loading: saveLoading,
                                              onPressed: () async {
                                                if (!saveLoading) {
                                                  setState(() {
                                                    saveLoading = true;
                                                    invalidMsg = [];
                                                  });

                                                  formKey.currentState.save();
                                                  final res = await Users()
                                                      .update(data, data['id']);
                                                  if (res['_meta']['success']) {
                                                    // save to local storage
                                                    final stringMe = json
                                                        .encode(res['result']);
                                                    final prefs =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    prefs.setString(
                                                        'me', stringMe);
                                                    Navigator
                                                        .pushReplacementNamed(
                                                            context,
                                                            'dashboard/3');
                                                  } else {
                                                    print(res);
                                                    if (res['result'][0] ==
                                                        null) {
                                                      invalidMsg
                                                          .add(res['result']);
                                                    } else {
                                                      invalidMsg = res['result'];
                                                    }
                                                  }

                                                  setState(() {
                                                    saveLoading = false;
                                                  });
                                                }
                                              }),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushReplacementNamed(
                                                context, '/dashboard/3');
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('B a c k',
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
            ),
          )),
    );
  }
}
