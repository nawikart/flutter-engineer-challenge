import 'package:flutter/material.dart';
import 'dart:async';
import '../../../utils/styles.dart';
import '../../components/mainDrawer.dart';
import '../../components/leftTopMenu.dart';
import '../../components/primaryButton.dart';
import '../../components/baseTextField.dart';
import '../../../api/me.dart';

class MeEditPage extends StatefulWidget {
  @override
  _MeEditPageState createState() => _MeEditPageState();
}

class _MeEditPageState extends State<MeEditPage> {
  bool loading = true;
  Map data;

  @override
  void initState() {
    super.initState();
    getMe();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, 'dashboard/2');
        return;
      },
      child: Scaffold(
          drawer: MainDrawer(),
          body: Container(
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
                          'EDIT ME',
                          style: theme.textTheme.title,
                        )),
                    (loading)
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(100),
                              child: CircularProgressIndicator(
                                strokeWidth: 1,
                              ),
                            ),
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height - 150,
                            child: SingleChildScrollView(
                              child: Container(
                                padding: const EdgeInsets.all(40),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: BaseTextField(
                                            initialValue: data['name'] ?? '',
                                            rounded: true,
                                            textAlign: TextAlign.center,
                                            labelText: 'Fullname')),
                                    Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: BaseTextField(
                                            initialValue: data['email'] ?? '',
                                            rounded: true,
                                            textAlign: TextAlign.center,
                                            labelText: 'Email')),
                                    Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: BaseTextField(
                                            initialValue: data['gender'] ?? '',
                                            rounded: true,
                                            textAlign: TextAlign.center,
                                            labelText: 'Gender')),
                                    Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: BaseTextField(
                                            initialValue: data['phone'] ?? '',
                                            rounded: true,
                                            textAlign: TextAlign.center,
                                            labelText: 'Phone')),
                                    Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: BaseTextField(
                                            initialValue: data['address'] ?? '',
                                            rounded: true,
                                            textAlign: TextAlign.center,
                                            labelText: 'Address')),
                                    Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: BaseTextField(
                                            initialValue: data['dob'] ?? '',
                                            rounded: true,
                                            textAlign: TextAlign.center,
                                            labelText: 'D.O.B')),
                                    Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: BaseTextField(
                                            initialValue: data['about'] ?? '',
                                            rounded: true,
                                            maxLines: 8,
                                            textAlign: TextAlign.center,
                                            labelText: 'About')),
                                    Container(
                                      margin: const EdgeInsets.only(top: 20),
                                      child: PrimaryButton(
                                          labelText: 'S a v e',
                                          width: 200,
                                          loading: loading,
                                          onPressed: () {
                                            setState(() {
                                              loading = true;
                                            });
                                            new Timer(
                                                const Duration(
                                                    milliseconds: 1000), () {
                                              Navigator.pushNamed(
                                                  context, 'dashboard/2');
                                            });
                                          }),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, 'dashboard/2');
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('b a c k',
                                            style: CustomTextStyle.smallLink(
                                                context)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
                LeftTopMenu()
              ],
            ),
          )),
    );
  }

  void getMe() async {
    final res = await MeApi().get(context);
    new Timer(const Duration(milliseconds: 300), () {
      setState(() {
        data = res;
        loading = false;
      });
    });
  }
}
