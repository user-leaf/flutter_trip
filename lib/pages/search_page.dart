import 'package:flutter/material.dart';
import 'package:flutter_trip/dao/search_dao.dart';
import 'package:flutter_trip/widget/search_bar.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String showText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('搜索页'),
      ),
      body: Column(
        children: [
          SearchBar(
            enabled: true,
            hideLeft: true,
            searchBarType: SearchBarType.normal,
            hint: '哈哈',
            defaultText: '123',
            leftButtonClick: () {
              Navigator.pop(context);
            },
            rightButtonClick: () {},
            speakClick: () {},
            inputBoxClick: () {},
            onChanged: _onTextChanged,
          ),
          InkWell(
            onTap: () {
              String url =
                  'https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=';
              Map<String, dynamic> canshu = {
                'source': 'mobileweb',
                'action': 'autocomplete',
                'contentType': 'json',
                'keyword': '长城',
              };
              Uri uri = Uri(
                  scheme: 'https',
                  host: 'm.ctrip.com',
                  path: '/restapi/h5api/searchapp/search',
                  queryParameters: canshu);
              SearchDao.fetch(uri).then((value) {
                setState(() {
                  showText = value.data[0].url;
                });
              }).catchError((e) {
                print('@@@' + e.toString());
              });
            },
            child: Text(
              'Get',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Text(showText),
        ],
      ),
    );
  }

  _onTextChanged(String text) {}
}
