import 'show.dart';

class Shows {
  final List<Show> shows;
  Shows(this.shows);

  Shows.fromJson(List<dynamic> json)
      : shows = (json as List)
            .map((i) => new Show.fromJson(i as Map<String, dynamic>))
            .toList();
}