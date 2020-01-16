import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'ui/auth/login.dart';
import 'ui/auth/register.dart';
import 'ui/dashboard/index.dart';
import 'ui/dashboard/me/editScreen.dart';
import 'ui/dashboard/list/room.dart';

class FluroRouter {
  static Router router = Router();

  static Handler _loginHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          LoginPage());

  static Handler _registerHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          RegisterPage());

  static Handler _dashboardHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          DashboardPage(index: params['index'][0]));

  static Handler _editMeHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          MeEditPage());

  static Handler _roomHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          RoomPage());


  //////////////////
  static void setupRouter() {
    router.define('/',
        handler: _loginHandler, transitionType: TransitionType.fadeIn);

    router.define('/register',
        handler: _registerHandler, transitionType: TransitionType.fadeIn);

    router.define('/dashboard/:index',
        handler: _dashboardHandler, transitionType: TransitionType.fadeIn);

    router.define('/me/edit',
        handler: _editMeHandler, transitionType: TransitionType.fadeIn);

    router.define('/friends/room',
        handler: _roomHandler, transitionType: TransitionType.fadeIn);
  }
}
