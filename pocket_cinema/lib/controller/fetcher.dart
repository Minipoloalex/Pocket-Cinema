import 'package:http/http.dart' as http;

class Fetcher{
  static Future searchMedia(String query) async {
    query = Uri.encodeComponent(query);
    final String url = "https://v3.sg.media-imdb.com/suggestion/x/$query.json";

    final response = await http.get(Uri.parse(url));
    return response.body;
  }
}