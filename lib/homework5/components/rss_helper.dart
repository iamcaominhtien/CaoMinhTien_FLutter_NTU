import 'dart:convert';
import 'package:caominhtien_61cntt2/homework5/components/vnexpress_rssitem.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'rss_item.dart';

class RSSHelper {
  // static String _rssURL = 'http://vnexpress.net/rss/tin-moi-nhat.rss';

  static Future<List<dynamic>?> fetchRSS() async {
    final response =
        await http.get(Uri.parse('http://vnexpress.net/rss/tin-moi-nhat.rss'));
    if (response.statusCode == 200) {
      final xml2Json = Xml2Json();
      xml2Json.parse(utf8.decode(response.bodyBytes));
      String rssJson = xml2Json.toParker();
      Map<String, dynamic> jsonData = jsonDecode(rssJson);
      return jsonData['rss']['channel']['item'];
    }
    return null;
  }

  static Future<List<RSSItem>> readVNExpressRSS() async {
    var rssJsons = await fetchRSS();
    if (rssJsons != null) {
      var listRSSItem = rssJsons.map((e) {
        var rss = VNExpressRSSItem().getRSSFromJson(e);
        var rawDescription = rss.description;
        rss.description = VNExpressRSSItem().getDescriprion(rawDescription!);
        rss.imgUrl = VNExpressRSSItem().getImgUrl(rawDescription);
        return rss;
      }).toList();
      return listRSSItem;
    } else {
      debugPrint('Can not load data');
      throw Exception('Can not load data');
    }
  }
}
