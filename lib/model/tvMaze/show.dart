import 'package:jiffy/jiffy.dart';

class Show {
  int id;
  String name;
  String type;
  String language;
  String image;
  String schedule;
  String network;
  double rating;

  Show.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    language = json['language'];
    image = (json['image'] != null) ? json['image']['medium'] : '';
    schedule =
        ((json['premiered'] != null) ? Jiffy(json['premiered']).yMMMMd : '') +
            ' / ' +
            json['schedule']['time'];
    network = (json['network'] != null)
        ? json['network']['name']
        : json['network'].toString();
    rating = double.parse((json['rating']['average'] ?? '0').toString());
  }
}
