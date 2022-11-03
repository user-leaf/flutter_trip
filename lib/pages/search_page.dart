import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/common_model.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String showResult = "";

  var url =
      Uri.http('www.devio.org', 'io/flutter_app/json/test_common_model.json');

  Future<CommonModel> fetchPost() async {
    final response = await http.get(url);
    final result = jsonDecode(response.body);
    return CommonModel.fromJson(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('搜索页'),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              fetchPost().then((CommonModel value) {
                setState(() {
                  showResult =
                      '请求结果: \nicon: ${value.icon} \ntitle: ${value.title} \nurl: ${value.url} \nstatusBarColor: ${value.statusBarColor} \nhideAppBar: ${value.hideAppBar}';
                });
              });
            },
            child: Text(
              '点我',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Text(showResult),
        ],
      ),
    );
  }
}