import 'dart:convert';

import 'package:belajar_api/model/album.dart';
import 'package:http/http.dart' as http;

class AlbumService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com/photos';
  static Future<List<Album>> fetchAlbum() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> result = jsonDecode(response.body);

        List<Album> albums =
            result.map((albumjson) => Album.fromJson(albumjson)).toList();

        return albums;
      } else {
        throw Exception('failed to load albums');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Album> updateAlbum(String title, String id) async {
    final response = await http.put(
      Uri.parse(baseUrl + id),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
      }),
    );
    if (response.statusCode == 200) {
      return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to update album.');
    }
  }

  // Future<Album> deleteAlbum(String id) async {
  //   final http.Response response = await http.delete(
  //     Uri.parse(baseUrl + id),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     return Album.empty(intalbumId, id, title, url, thumbnailUrl)
  //   } else {
  //     throw Exception('Failed to delete album.');
  //   }
  // try {
  //   final response = await http.delete(Uri.parse(baseUrl + id));
  //   if (response.statusCode == 200) {
  //     return Album.empty();
  //   } else {
  //     throw Exception('Failed to delete album');
  //   }
  // } catch (e) {
  //   throw Exception(e.toString());
  // }
  // }
}

  // Future putData(int id, String title, String url) async {
  //   try {
  //     final response =
  //         await http.put(Uri.parse(baseUrl + id.toString()), body: {
  //       'title': title,
  //       'url': url,
  //     });
  //     if (response.statusCode == 200) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

