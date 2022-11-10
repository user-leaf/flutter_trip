import 'package:flutter/material.dart';
import 'package:flutter_trip/widget/search_bar.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
        ],
      ),
    );
  }

  _onTextChanged(String text) {

  }
}
