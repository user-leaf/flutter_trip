import 'package:flutter/material.dart';
import 'package:flutter_trip/pages/travel_item.dart';

class TravelPage extends StatefulWidget {
  @override
  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 200,
        height: 300,
        child: TravelItem(),
      ),
    );
  }
}
