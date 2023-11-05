import 'dart:math';

abstract class ActionDataSource {
  const ActionDataSource();

  void move(Point from, Point to);

  void zoom(double scale);
}
