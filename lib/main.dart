import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/myProvider.dart';
import 'router.dart';
import 'ui/components/dynamicTheme/dynamicTheme.dart';

void main() {
  FluroRouter.setupRouter();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => MyProvider())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new DynamicTheme(
        defaultColor: 'dark',
        themedWidgetBuilder: (context, theme) {
          return new MaterialApp(
              title: 'Flutter Engineer Challenge',
              theme: theme,
              initialRoute: '/',
              onGenerateRoute: FluroRouter.router.generator);
        });
  }
}
