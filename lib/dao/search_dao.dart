import 'dart:convert';

import 'package:flutter_trip/model/search_model.dart';
import 'package:http/http.dart' as http;

import '../model/home_model.dart';

class SearchDao {
  static Future<SearchModel> fetch(Uri uri) async {
    // Uri uri = Uri(scheme: 'http', host: 'www.devio.org', path: '/io/flutter_app/json/home_page.json');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder(); // fix 中文乱码
      var result = jsonDecode(utf8decoder.convert(response.bodyBytes));
      // return Future.value(SearchModel.fromJson(result));
      return SearchModel.fromJson(result);
    } else {
      throw Exception('Failed to load search_page.json');
    }
  }
}
