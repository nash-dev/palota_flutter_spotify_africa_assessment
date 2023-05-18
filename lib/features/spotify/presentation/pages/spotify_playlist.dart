/* import 'package:flutter/material.dart';

//TODO: complete this page - you may choose to change it to a stateful widget if necessary
class SpotifyPlaylist extends StatelessWidget {
  const SpotifyPlaylist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
 */
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SpotifyPlaylist extends StatefulWidget {
  const SpotifyPlaylist({Key? key}) : super(key: key);

  @override
  SpotifyPlaylistState createState() => SpotifyPlaylistState();
}

class SpotifyPlaylistState extends State<SpotifyPlaylist> {
  Future<void> fetchPlaylistData() async {
    var headers = {
      'x-functions-key':
          '_q6Qaip9V-PShHzF8q9l5yexp-z9IqwZB_o_6x882ts3AzFuo0DxuQ=='
    };

    var url = Uri.parse(
        'https://palota-jobs-africa-spotify-fa.azurewebsites.net/api/browse/categories/afro/playlists');

    await http.get(url, headers: headers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spotify Playlist'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            fetchPlaylistData();
          },
          child: const Text('Fetch Playlist'),
        ),
      ),
    );
  }
}
