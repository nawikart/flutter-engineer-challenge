import 'package:flutter/material.dart';
import 'dart:convert';
//import '../model/meModel.dart';

class MeApi {
  Future<Map> get(BuildContext context) async {
    String result = await DefaultAssetBundle.of(context)
        .loadString("assets/data/me.json");
//    return MeModel.fromJson(json.decode(result));
    return json.decode(result)['data'];
  }
}
