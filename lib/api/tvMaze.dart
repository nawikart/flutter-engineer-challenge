import 'package:http/http.dart' as http;
import 'requestHandling/returnResponse.dart';
import '../model/tvMaze/show.dart';

class TvMaze {
  final String baseUrl = 'http://api.tvmaze.com';

  Future<Show> fetchShow(int id) async {
    final response = await http.get('$baseUrl/shows/$id');
    final json = returnResponse(response);

    return Show.fromJson(json);
  }

  Future<List<Show>> fetchListShow() async {
    final response = await http.get('$baseUrl/search/shows?q=football');
      List shows = returnResponse(response);

      List<Show> result = [];
      for (int i = 0; i < shows.length; i++) {
        if (shows[i]['show']['image'] != null) {
          result.add(Show.fromJson(shows[i]['show']));
        }
      }
      return result;
  }
}
