import 'package:flutter/material.dart';
import 'dart:async';
import '../../components/primaryButton.dart';
import '../../../utils/styles.dart';
import '../../../api/me.dart';

class MePage extends StatefulWidget {
  @override
  _MePageState createState() => _MePageState();
}

class _MePageState extends State<MePage> {
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
    return (loading)
        ? Padding(
            padding: const EdgeInsets.all(100),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(
                strokeWidth: 1,
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(150),
                  child: Image.asset("assets/avatar.jpeg", width: 150),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    data['name'] ?? '',
                    style: theme.textTheme.display1,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, 'me/edit');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        Text('Edit', style: CustomTextStyle.smallLink(context)),
                  ),
                ),
                Text(data['phone'] ?? '', style: theme.textTheme.title),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(data['email'] ?? ''),
                ),
                Text((data['gender'] ?? '') + '/' + (data['dob'] ?? '')),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(
                    'about:',
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    data['about'] ?? '',
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: PrimaryButton(
                      labelText: 'L o g o u t',
                      width: 200,
                      onPressed: () {
                        Navigator.pushNamed(context, '/');
                      }),
                ),
              ],
            ),
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
