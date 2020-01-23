import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/loadingPage.dart';
import '../../components/primaryButton.dart';
import '../../../utils/styles.dart';
import '../../../model/user.dart';

class MePage extends StatefulWidget {
  @override
  _MePageState createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  User data;

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((prefs) {
      data = User.fromJson(json.decode(prefs.getString('me')));
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return (data == null)
        ? LoadingPage()
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
                    data.displayName ?? '',
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
                Text(data.phone ?? '', style: theme.textTheme.title),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(data.email ?? ''),
                ),
                Text((data.gender ?? '') + '/' + (data.dob ?? '')),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Text(
                    "\"Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content.\"",
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: PrimaryButton(
                      labelText: 'L o g o u t',
                      width: 200,
                      onPressed: () async {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        preferences.clear();

                        Navigator.pushReplacementNamed(context, '/');
                      }),
                ),
              ],
            ),
          );
  }
}
