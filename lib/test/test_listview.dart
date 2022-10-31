import 'package:flutter/material.dart';

class TestListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TestListViewState();
}

class _TestListViewState extends State<TestListView> {
  final title = '列表';
  List<String> cities = [
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

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        _loadData();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: RefreshIndicator(
        child: ListView(
          children: _getListView(),
          controller: _scrollController,
        ),
        onRefresh: _handleRefresh,
      ),
    );
  }

  Future<Null> _handleRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      cities = cities.reversed.toList();
    });
    return null;
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

  void _loadData() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      List<String> list = List<String>.from(cities);
      list.addAll(cities);
      cities = list;
    });
  }
}
