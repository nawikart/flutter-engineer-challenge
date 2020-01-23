import 'package:http/http.dart' as http;
import 'dart:convert';
import 'requestHandling/returnResponse.dart';
import '../model/user.dart';

class Users {
  final String baseUrl = 'https://gorest.co.in/public-api/users';
  final String goRestToken = '5-aM9pt53Z_JPqPW_-mv-rtYR0sn68hljqlS';

  Future<Map> create(Map data) async {
    var body = json.encode(data);
    final resp = await http.post(
      baseUrl,
      body: body,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer $goRestToken"
      },
    );
    return returnResponse(resp);
  }

  Future<Map> update(Map data, String id) async {
    var body = json.encode(data);
    final resp = await http.put(
      '$baseUrl/$id',
      body: body,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer $goRestToken"
      },
    );
    return returnResponse(resp);
  }

  Future<List<User>> list() async {
    final resp = await http.get('$baseUrl?page=25', headers: {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $goRestToken"
    });
    final json = returnResponse(resp);

    List users = json['result'];
    List<User> result = [];
    for (int i = 0; i < users.length; i++) {
      if (users[i]['_links']['avatar']['href'] != null) {
        result.add(User.fromJson(users[i]));
      }
    }
    return result;
  }

  Future<Map> getByEmail(String keyword) async {
    final resp = await http.get('$baseUrl?email=$keyword', headers: {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $goRestToken"
    });
    return returnResponse(resp);
  }
}
