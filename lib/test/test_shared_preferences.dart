import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestSharedPreferences extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TestSharedPreferencesState();
}

class _TestSharedPreferencesState extends State<TestSharedPreferences> {
  String content = "";
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('计数器'),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                _incrementCounter();
              },
              child: Text('Increment Counter'),
            ),
            Text(content),
            TextButton(
              onPressed: () {
                _getCounter();
              },
              child: Text('Get Counter'),
            ),
            Text('result:$count'),
          ],
        ),
      ),
    );
  }

  void _incrementCounter() async {
    final prefs = await SharedPreferences.getInstance();
    content = prefs.getString('content') ?? "";
    setState(() {
      content = "1$content";
      prefs.setString('content', content);
    });
  }

  void _getCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      count = prefs.getString('content')?.length ?? 0;
    });
  }
}
