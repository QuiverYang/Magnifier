import 'dart:math';

abstract class ActionRepo {
  const ActionRepo();

  void move(Point from, Point to);

  void zoom(double scale);
}
