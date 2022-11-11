import 'dart:convert';

import 'package:flutter_trip/model/search_model.dart';
import 'package:http/http.dart' as http;

class SearchDao {
  static Future<SearchModel> fetch(Uri uri, String text) async {
    // Uri uri = Uri(scheme: 'http', host: 'www.devio.org', path: '/io/flutter_app/json/home_page.json');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder(); // fix 中文乱码
      var result = jsonDecode(utf8decoder.convert(response.bodyBytes));
      // return Future.value(SearchModel.fromJson(result));

      // 只有当当前输入的内容和服务端返回的内容一致时才渲染
      SearchModel model = SearchModel.fromJson(result);
      model.keyword = text;
      return model;
    } else {
      throw Exception('Failed to load search_page.json');
    }
  }
}
