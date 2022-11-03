import 'package:flutter/material.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';

class GridNav extends StatefulWidget {
  final GridNavModel? gridNavModel;
  final String name;

  const GridNav(
      {super.key, required this.gridNavModel, this.name = 'xiaoming'});

  // @override
  // Widget build(BuildContext context) {
  //   return Text('GridNav');
  // }

  @override
  _GridNavState createState() => _GridNavState();
}

class _GridNavState extends State<GridNav> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.name);
  }
}
