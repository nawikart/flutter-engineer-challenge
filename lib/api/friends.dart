import 'package:flutter/material.dart';
import 'dart:convert';
//import '../model/friends/listFriends.dart';

class FriendsApi {
  Future<List> list(BuildContext context) async {
    String result = await DefaultAssetBundle.of(context)
        .loadString("assets/data/friends.json");
//    return ListFriends.fromJson(json.decode(result));
    return (json.decode(result))['data'];
  }
}
