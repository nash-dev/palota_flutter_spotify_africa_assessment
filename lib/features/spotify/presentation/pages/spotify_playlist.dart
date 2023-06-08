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
import 'dart:async';
import 'dart:convert';

/* class SpotifyPlaylist extends StatefulWidget {
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
 */
/*   @override
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
}*/
Future<Playlist> fetchPlaylist() async {
  var headers = {
    'x-functions-key':
        '_q6Qaip9V-PShHzF8q9l5yexp-z9IqwZB_o_6x882ts3AzFuo0DxuQ=='
  };

  var url = Uri.parse(
      'https://palota-jobs-africa-spotify-fa.azurewebsites.net/api/browse/categories/afro/playlists');

  final response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Playlist.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Playlist {
  String? href;
  List<Items>? items;
  int? limit;
  String? next;
  int? offset;
  String? previous;
  int? total;

  Playlist(
      {this.href,
      this.items,
      this.limit,
      this.next,
      this.offset,
      this.previous,
      this.total});

  Playlist.fromJson(Map<String, dynamic> json) {
    href = json['href'] ?? '';
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    limit = json['limit'];
    next = json['next'] ?? '';
    offset = json['offset'];
    previous = json['previous'] ?? '';
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['limit'] = this.limit;
    data['next'] = this.next;
    data['offset'] = this.offset;
    data['previous'] = this.previous;
    data['total'] = this.total;
    return data;
  }
}

class Items {
  bool? collaborative;
  String? description;
  ExternalUrls? externalUrls;
  String? href;
  String? id;
  List<Images>? images;
  String? name;
  Owner? owner;
  Null primaryColor;
  Null public;
  String? snapshotId;
  Tracks? tracks;
  String? type;
  String? uri;

  Items(
      {this.collaborative,
      this.description,
      this.externalUrls,
      this.href,
      this.id,
      this.images,
      this.name,
      this.owner,
      this.primaryColor,
      this.public,
      this.snapshotId,
      this.tracks,
      this.type,
      this.uri});

  Items.fromJson(Map<String, dynamic> json) {
    collaborative = json['collaborative'];
    description = json['description'];
    externalUrls = json['external_urls'] != null
        ? ExternalUrls.fromJson(json['external_urls'])
        : null;
    href = json['href'];
    id = json['id'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    name = json['name'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    primaryColor = json['primary_color'];
    public = json['public'];
    snapshotId = json['snapshot_id'];
    tracks = json['tracks'] != null ? Tracks.fromJson(json['tracks']) : null;
    type = json['type'];
    uri = json['uri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['collaborative'] = collaborative;
    data['description'] = description;
    if (externalUrls != null) {
      data['external_urls'] = externalUrls!.toJson();
    }
    data['href'] = href;
    data['id'] = id;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    if (this.owner != null) {
      data['owner'] = this.owner!.toJson();
    }
    data['primary_color'] = this.primaryColor;
    data['public'] = this.public;
    data['snapshot_id'] = this.snapshotId;
    if (this.tracks != null) {
      data['tracks'] = this.tracks!.toJson();
    }
    data['type'] = this.type;
    data['uri'] = this.uri;
    return data;
  }
}

class ExternalUrls {
  String? spotify;

  ExternalUrls({this.spotify});

  ExternalUrls.fromJson(Map<String, dynamic> json) {
    spotify = json['spotify'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['spotify'] = spotify;
    return data;
  }
}

class Images {
  Null height;
  String? url;
  Null width;

  Images({this.height, this.url, this.width});

  Images.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    url = json['url'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['height'] = height;
    data['url'] = url;
    data['width'] = width;
    return data;
  }
}

class Owner {
  String? displayName;
  ExternalUrls? externalUrls;
  String? href;
  String? id;
  String? type;
  String? uri;

  Owner(
      {this.displayName,
      this.externalUrls,
      this.href,
      this.id,
      this.type,
      this.uri});

  Owner.fromJson(Map<String, dynamic> json) {
    displayName = json['display_name'];
    externalUrls = json['external_urls'] != null
        ? ExternalUrls.fromJson(json['external_urls'])
        : null;
    href = json['href'];
    id = json['id'];
    type = json['type'];
    uri = json['uri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['display_name'] = this.displayName;
    if (this.externalUrls != null) {
      data['external_urls'] = this.externalUrls!.toJson();
    }
    data['href'] = this.href;
    data['id'] = this.id;
    data['type'] = this.type;
    data['uri'] = this.uri;
    return data;
  }
}

class Tracks {
  String? href;
  int? total;

  Tracks({this.href, this.total});

  Tracks.fromJson(Map<String, dynamic> json) {
    href = json['href'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    data['total'] = this.total;
    return data;
  }
/* 
  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      href: json['userId'],
      items: json['id'],
      title: json['title'],
    );
  } */
}

void main() => runApp(const SpotifyPlaylist());

class SpotifyPlaylist extends StatefulWidget {
  const SpotifyPlaylist({super.key});

  @override
  State<SpotifyPlaylist> createState() => SpotifyPlaylistState();
}

class SpotifyPlaylistState extends State<SpotifyPlaylist> {
  //late Future<Playlist> futureAlbum;
  //Future<Playlist> futureAlbum = fetchPlaylist();

  //Future<List<Playlist>>? futureAlbumList = futureAlbum.then((Playlist) => [Playlist]);
  Future<Playlist> futureAlbum = fetchPlaylist();
  Future<List<Playlist>>? futureAlbumList;

  SpotifyPlaylistState() {
    futureAlbum = fetchPlaylist();
    futureAlbumList = futureAlbum.then((album) => [album]);
  }

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchPlaylist();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<List<Playlist>>(
            future: futureAlbumList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final playlist = snapshot.data?[0];
                return Text(playlist?.toJson().toString() ?? '');
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
