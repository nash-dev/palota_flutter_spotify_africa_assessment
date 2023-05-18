import 'dart:js_interop';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spotify_africa_assessment/features/spotify/presentation/pages/constants.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/presentation/pages/model.dart';

// TODO: fetch and populate playlist info and allow for click-through to detail
// Feel free to change this to a stateful widget if necessary
/* class SpotifyCategory extends StatelessWidget {
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
        child: Center(
          child: Text(
            '''Populate with playlist info for category '$categoryId', click on playlist to view playlist detail''',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
 */

class SpotifyCategory extends StatelessWidget {
  final String categoryId;

  const SpotifyCategory({
    Key? key,
    required this.categoryId,
  }) : super(key: key);

   Future<List<dynamic>> fetchPlaylists() async {
    final response = await http.get(
      Uri.parse(
          'https://palota-jobs-africa-spotify-fa.azurewebsites.net/api/browse/categories/afro'),
      headers: {
        'x-functions-key':
            '_q6Qaip9V-PShHzF8q9l5yexp-z9IqwZB_o_6x882ts3AzFuo0DxuQ=='
      },
    );
    
    List<Product> parseProducts(String responseBody) { 
   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>(); 
   return parsed.map<Product>((json) =>Product.fromJson(json)).toList(); 
} 
Future<List<Product>> fetchProducts() async { 
   final response = await http.get('http://192.168.1.2:8000/products.json'); 
   if (response.statusCode == 200) { 
      return parseProducts(response.body); 
   } else { 
      throw Exception('Unable to fetch products from the REST API');
   } 
}
/*        Future<List<dynamic>> fetchPlaylists() async {
    final response = await http.get(
      Uri.parse(
          'https://palota-jobs-africa-spotify-fa.azurewebsites.net/api/browse/categories/afro'),
      headers: {
        'x-functions-key':
            '_q6Qaip9V-PShHzF8q9l5yexp-z9IqwZB_o_6x882ts3AzFuo0DxuQ=='
      },
    );
 */     
/*     Future<List<dynamic>> fetchPlaylists() async {
    var headers = {
    'x-functions-key': '_q6Qaip9V-PShHzF8q9l5yexp-z9IqwZB_o_6x882ts3AzFuo0DxuQ=='
    };
    var request = http.Request('GET', Uri.parse('https://palota-jobs-africa-spotify-fa.azurewebsites.net/api/browse/categories/afro'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();


    if (response.statusCode == 200) {
      final playlists = response['playlist'];
      if (playlists != null) {
        return playlists;
      } else {
        throw Exception('Playlists data is null');
      }
    } else {
      throw Exception('Failed to fetch playlists');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category Name'),
        // ... rest of the code
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchPlaylists(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final playlists = snapshot.data!;
            return ListView.builder(
              itemCount: playlists.length,
              itemBuilder: (context, index) {
                final playlist = playlists[index];
                return ListTile(
                  title: Text(playlist['name']),
                  onTap: () {
                    // Handle playlist item click here
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
   