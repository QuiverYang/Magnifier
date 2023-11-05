import 'package:magnifier/data/data_sources/action_data_sources.dart';
import 'dart:math';
import 'package:flutter/material.dart';

class ActionDataSourceImpl implements ActionDataSource {
  ActionDataSourceImpl({this.onPanUpdateCallback, this.onTapDownCallback});


  final Function(DragUpdateDetails details)? onPanUpdateCallback;
  final Function? onTapDownCallback;

  @override
  void move(Point from, Point to) {
    // TODO: implement move
  }

  @override
  void zoom(double scale) {
    // TODO: implement zoom
  }

}