import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/colors.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/presentation/pages/spotify_playlist.dart';
import 'package:flutter_spotify_africa_assessment/routes.dart';
import 'api_Handler.dart';

// TODO: fetch and populate playlist info and allow for click-through to detail
// Feel free to change this to a stateful widget if necessary
class SpotifyCategory extends StatelessWidget {
  void didChangeDependencies() {
    ApiHandler.getAllCategories();
  }

  final String categoryId;

  const SpotifyCategory({
    Key? key,
    required this.categoryId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("{CategoryName}"),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => Navigator.of(context).pushNamed(AppRoutes.about),
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                AppColors.blue,
                AppColors.cyan,
                AppColors.green,
              ],
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SpotifyPlaylist(key: key)),
                );
              },
              child: const Text('Display Playlists'),
            ),
            const SizedBox(height: 16),
            Text(
              '''Populate with playlist info for category '$categoryId', click on playlist to view playlist detail''',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

/*   void fetchAndDisplayPlaylists(BuildContext context) {
    // Use your API handler to fetch playlists for the given categoryId
    // Assuming `ApiHandler.getPlaylistsByCategory` returns a Future<List<Playlist>>
    ApiHandler.getPlaylist(categoryId).then((playlists) {
      // Once the playlists are fetched, navigate to a new screen to display them
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PlaylistScreen(playlists: playlists),
        ),
      );
    }).catchError((error) {
      // Handle error if the API call fails
      // Display an error message or show a snackbar, for example
      print('Failed to fetch playlists: $error');
    });
  } */
}
