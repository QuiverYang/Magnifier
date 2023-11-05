part of 'magnifier_bloc.dart';

abstract class MagnifierState extends Equatable {

  const MagnifierState(this.circle);
  final Circle circle;
}

class MagnifierInitial extends MagnifierState {
  const MagnifierInitial()
      : super(const Circle(center: Point<double>(100, 100), radius: 100));

  @override
  List<Object> get props => [circle];
}

class MagnifierModified extends MagnifierState {
  MagnifierModified({
    required Point<double> newCenter,
    required double newRadius,
  }) : super(Circle(center: newCenter, radius: newRadius));

  @override
  List<Object> get props => [circle];
}
