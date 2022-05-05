import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Photo {
  final int? albumId;
  final int? id;
  final String? title;
  final String? url;
  final String? thumbnailUrl;
  Photo({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});
  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
        albumId: json['albumId'] as int,
        id: json['id'] as int,
        title: json['title'] as String,
        url: json['url'] as String,
        thumbnailUrl: json['thumbnailUrl'] as String);
  }

  // Photo.fromJson(Map<String, dynamic> json)
  //     : albumId = json['albumId'] as int,
  //       id = json['id'] as int,
  //       title = json['title'] as String,
  //       url = json['url'] as String,
  //       thumbnailUrl = json['thumbnailUrl'] as String;

  Future<List<Photo>> fetchPhotos() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    if (response.statusCode == 200) {
      List<Photo> photos;
      var list = json.decode(response.body) as List;
      photos = list.map((item) => Photo.fromJson(item)).toList();
      debugPrint(photos.length.toString());
      return photos;
    } else {
      debugPrint("Không tải được Album");
      throw Exception("Khong tai duoc Album");
    }
  }
}
