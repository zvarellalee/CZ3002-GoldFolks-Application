import 'package:http/http.dart' as http;
import 'dart:convert';

class VideoDetailFetcher {
  static Future<dynamic> getVideoInfo(String videoId) async{
    var response = await http.get(Uri.parse("https://www.youtube.com/oembed?url=https://www.youtube.com/watch?v=$videoId&format=json"));

    try {
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print("Error in format");
    }
  }
}