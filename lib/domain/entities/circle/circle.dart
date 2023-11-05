import 'dart:math';

import 'package:equatable/equatable.dart';

class Circle extends Equatable {
  const Circle({
    required this.center,
    required this.radius,
  });

  final Point<double> center;
  final double radius;

  double get left => center.x - radius;

  double get top => center.y - radius;

  @override
  List<Object?> get props => [center, radius];
}
