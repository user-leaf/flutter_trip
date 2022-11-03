import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/home_model.dart';

const HOME_URL = 'http://www.devio.org/io/flutter_app/json/home_page.json';

///首页大接口
class HomeDao {
  static Future<HomeModel> fetch() async {
    Uri uri = Uri(scheme: 'http', host: 'www.devio.org', path: '/io/flutter_app/json/home_page.json');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder(); // fix 中文乱码
      var result = jsonDecode(utf8decoder.convert(response.bodyBytes));
      return HomeModel.fromJson(result);
    } else {
      throw Exception('Failed to load home_page.json');
    }
  }
}
