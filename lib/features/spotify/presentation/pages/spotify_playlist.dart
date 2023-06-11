import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Playlist {
  final String name;
  final String description;
  final String imageUrl;
  final String externalUrl;

  Playlist({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.externalUrl,
  });
}

Future<List<Playlist>> fetchPlaylist() async {
  var headers = {
    'x-functions-key': '_q6Qaip9V-PShHzF8q9l5yexp-z9IqwZB_o_6x882ts3AzFuo0DxuQ=='
  };

  var url = Uri.parse(
      'https://palota-jobs-africa-spotify-fa.azurewebsites.net/api/browse/categories/afro/playlists');

  final response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final items = data['playlists']['items'];
    return items
        .where((item) =>
            item['name'] != null &&
            item['description'] != null &&
            item['images'] != null)
        .map<Playlist>((item) => Playlist(
              name: item['name'],
              description: item['description'],
              imageUrl: item['images'][0]['url'],
              externalUrl: item['external_urls']['spotify'],
            ))
        .toList();
  } else {
    throw Exception('Failed to load playlists');
  }
}

void main() {
  runApp(const SpotifyPlaylist());
}

class SpotifyPlaylist extends StatefulWidget {
  const SpotifyPlaylist({Key? key}) : super(key: key);

  @override
  _SpotifyPlaylistState createState() => _SpotifyPlaylistState();
}

class _SpotifyPlaylistState extends State<SpotifyPlaylist> {
  late Future<List<Playlist>> futurePlaylist;

  @override
  void initState() {
    super.initState();
    futurePlaylist = fetchPlaylist();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotify Playlist',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Spotify Playlist'),
        ),
        body: Center(
          child: FutureBuilder<List<Playlist>>(
            future: futurePlaylist,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final playlists = snapshot.data!;
                return ListView.builder(
                  itemCount: playlists.length,
                  itemBuilder: (context, index) {
                    final playlist = playlists[index];
                    return ListTile(
                      title: Text(playlist.name),
                      subtitle: Text(playlist.description),
                      leading: Image.network(playlist.imageUrl),
                      onTap: () {
                        // Handle playlist item tap
                        // You can navigate to a new screen or perform any other action here
                      },
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
