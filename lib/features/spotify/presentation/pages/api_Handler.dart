import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_Constants.dart';

class ApiHandler {
  static Future<void> getAllCategories() async {
    var uri = Uri.https(ApiConstants.baseUrl, ApiConstants.usersEndpoint);
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'X-API-Key': '_q6Qaip9V-PShHzF8q9l5yexp-z9IqwZB_o_6x882ts3AzFuo0DxuQ==',
    };

    var response = await http.get(uri, headers: headers);
    print("response ${jsonDecode(response.body)}");
  }

  static Future<void> getPlaylist() async {
    var uri2 = Uri.https(ApiConstants.baseUrl, ApiConstants.playlistEndpoint);
    var response2 = await http.get(uri2);
    print("response ${jsonDecode(response2.body)}");
  }
}
