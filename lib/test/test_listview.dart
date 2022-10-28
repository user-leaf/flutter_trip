import 'package:flutter/material.dart';

class TestListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TestListViewState();
}

class _TestListViewState extends State<TestListView> {
  final title = '列表';
  List cities = [
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        children: _getListView(),
      ),
    );
  }

  _getListView() {
    return cities.map((e) => _item(e)).toList();
  }

  Widget _item(e) {
    return Container(
      height: 80,
      margin: EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(color: Colors.blue),
      child: Center(
        child: Text(
          e,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
